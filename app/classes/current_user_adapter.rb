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
  def find_parent(usr)
    User.find_by id: usr.parent_id
  end
  def children_list
    fetch_children_list(user, [])
  end
  def fetch_children_list(usr, result=[])
    (ch = usr.children).present? && ch.each { |u| result.push(u); fetch_children_list(u, result) } || result
  end
  def direct_bonus_users_count
    created_users.where(is_package_activated:  true).map { |usr| usr.package_price * 0.06 }.sum
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
  def indirect_bonus_users_count
    children_list.map { |usr| usr.is_package_activated ? usr.package_price * 0.03 : 0.00  }.sum
  end
  def find_packages
    @find_package ||= FindPackages.new(package_id)
  end
  def package_price
    current_package ? current_package[:price] : 0.00
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
  delegate :calculate, :current_rank, to: :cupda, allow_nil: true, prefix: true
  delegate :current_package, to: :find_packages, allow_nil: true
  delegate :package_id, :created_users, to: :user, allow_nil: true
end
