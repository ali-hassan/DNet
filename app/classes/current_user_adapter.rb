class CurrentUserAdapter
  attr_accessor :user
  def initialize(user)
    self.user = user
  end

  def find_last_node(usr, position)
    ( _ = current_child(usr, position)) && find_last_node(_, position) || usr
  end
  def current_child(u, po)
    u.children.find_by parent_position: po
  end
  class_eval do
    %w(right left).each do |pstn|
      define_method "find_last_#{pstn}_node" do
        find_last_node(user, pstn)
      end
    end
  end
  def parent_lists
    fetch_parent_list(user, [])
  end
  def fetch_parent_list(usr, result=[])
    (_=find_parent(usr)).present? && (result.push(_); fetch_parent_list(_, result)) || result
  end
  def find_parent(usr, mthd=:parent_id)
    User.find_by id: usr.send(mthd)
  end
  def fetch_linked_parent_list(usr, result=[])
    (_=find_parent(usr, :created_by_id)).present? && (result.push(_); fetch_linked_parent_list(_, result)) || result
  end
  def linked_parent_list
    fetch_linked_parent_list(user)
  end
  def children_list
    fetch_children_list(user, [])
  end
  def fetch_children_list(usr, result=[], max_lvl=0, current_lvl=0)
    children_condition?(ch=usr.children, max_lvl, current_lvl) && ch.each { |u| result.push(u); fetch_children_list(u, result, max_lvl, current_lvl+1) } || result
  end
  def children_condition?(children, max_lvl, current_lvl)
    children.present? && (max_lvl != 0 || max_lvl >= current_lvl) || false
  end
  def children_list_lvl_3
    fetch_children_list(user, [], 6)
  end
  def direct_bonus_users_count
    user.current_bonus_points.try(:to_f)
  end
  def direct_users
    created_users.where(is_package_activated:  true)
  end
  def direct_bonus_users_count_left
    created_users.where(is_package_activated:  true, parent_position: "left").map { |usr| usr.package_price * 0.06 }
  end
  def direct_bonus_users_count_right
    created_users.where(is_package_activated:  true, parent_position: "right").map { |usr| usr.package_price * 0.06 }
  end
  def left_team_members_count
    children_list.reject { |child| child.parent_position != "left" }.count
  end
  def right_team_members_count
    children_list.reject { |child| child.parent_position != "right" }.count
  end
  def indirect_bonus_users_count
    indirect_total_bonus_amount.try(:to_f)
  end
  def find_packages
    @find_package ||= FindPackages.new(package_id)
  end
  def package_price
    current_package ? current_package[:price] : 0.00
  end
  def cash_wallet_total
    direct_bonus_users_count + indirect_bonus_users_count + user.current_total_weekly_roi_amount.try(:to_f)
  end
  def earn_weekly_point
    perform_weekly_count.perform
  end

  def perform_weekly_count
    @perform_weekly_count ||= PerformWeeklyUser.new(user)
  end
  def cupda
    @cupda ||= CalculateUserParentDirectBonus.new(user)
  end
  def apply_indirect_bonus_at(index, package_price)
    pp = package_price / 100 * (Setting.find_value("default_indirect_bonus_%_at_lvl_#{index+1}").value.try(:to_f))
    user.update(
        total_income: user.total_income.try(:to_f) + pp,
        indirect_bonus_amount: indirect_bonus_amount.try(:to_f) + pp,
        indirect_total_bonus_amount: indirect_total_bonus_amount.try(:to_f) + pp
    )
  end
  def binary_bonus
    (user.right_bonus.to_f > user.left_bonus.to_f) && (user.left_bonus.try(:to_f) / 2) || (user.right_bonus.try(:to_f) / 2)
  end
  delegate :calculate, :current_rank, to: :cupda, allow_nil: true, prefix: true
  delegate :current_package, to: :find_packages, allow_nil: true
  delegate :package_id, :created_users, :indirect_total_bonus_amount, :indirect_bonus_amount, to: :user, allow_nil: true
end
