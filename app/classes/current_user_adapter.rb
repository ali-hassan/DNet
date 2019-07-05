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
  def last_node_parent_list
    [find_last_left_node, find_last_right_node].flatten.compact
  end
  def last_node_parent_id
    last_node_parent_list.map(&:id) rescue []
  end
  def calculate_binary_bonus
    ((left_bonus.to_f > right_bonus.to_f) && right_bonus || left_bonus).try(:to_f) * 0.50
  end
  def parent_lists
    fetch_parent_list(user, [])
  end
  def fetch_parent_list(usr, result=[])
    (_=find_parent(usr)).present? && (result.push(_); fetch_parent_list(_, result); result) || result
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
    created_users.where("package_id IS NOT NULL")
  end
  def all_users
    created_users
  end
  def direct_bonus_users_count_left
    created_users.where(is_package_activated:  true, parent_position: "left").map { |usr| usr.package_price * 0.06 }
  end
  def direct_bonus_users_count_right
    created_users.where(is_package_activated:  true, parent_position: "right").map { |usr| usr.package_price * 0.06 }
  end
  def left_team_members_count
    (ch = user.children.where(parent_position: "left").first) && (ch.adapter.find_child_list_by_parent_id.count + 1) || 0
  end
  def right_team_members_count
    (ch = user.children.where(parent_position: "right").first) && (ch.adapter.find_child_list_by_parent_id.count + 1) || 0
  end
  def find_child_list_by_parent_id
    child_list_by_parent_id(user, [])
  end
  def child_list_by_parent_id(usr, result=[])
    (chld = User.where(parent_id: usr.id)).present? && (chld.each { |u| result.push(u); child_list_by_parent_id(u, result) }; result) || result
  end
  def indirect_bonus_users_count
    indirect_total_bonus_amount.try(:to_f)
  end
  def find_packages
    @find_package ||= FindPackages.new(package_id)
  end
  def package_price
    user.charge_package_price.try(:to_f)
  end
  def cash_wallet_total
    (direct_bonus_users_count + indirect_bonus_users_count + binary_bonus.try(:to_f) + weekly_roi_to_cash_amount.try(:to_f)) - user.cash_wallet_minus.to_f
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
  def scheduler_update
    @scheduler_update ||= SchedulerUpdate.new(user)
  end
  def apply_indirect_bonus_at(index, package_price, usr)
    pp = package_price / 100 * (Setting.find_value("default_indirect_bonus_%_at_lvl_#{index+1}").value.try(:to_f))
    if perform_weekly_count.calculate_condition(pp)
      user.log_histories.create(logable: usr, message: "Indirect bonus #{pp}$ on #{usr.username} for package #{package_price.to_f}$", log_type: 'indirect_bonus')
      user.update(
        current_x_factor_income: user.current_x_factor_income.try(:to_f) + pp,
        total_income: user.total_income.try(:to_f) + pp,
        indirect_bonus_amount: indirect_bonus_amount.try(:to_f) + pp,
        indirect_total_bonus_amount: indirect_total_bonus_amount.try(:to_f) + pp,
        cash_wallet_amount: user.cash_wallet_amount.try(:to_f) + pp,
      )
    end
  end
  def max_package_total_earning
    selected_earning_method
  end
  def selected_earning_method
    {
      pin: user.pin_capacity.try(:to_f) * 4,
      package: find_packages.try(:xfactor_amount).try(:to_f)
    }[ user.is_pin? && :pin || :package ]
  end
  def pin_or_package_amount
    {
      pin: user.pin_capacity.try(:to_f),
      package:  current_package[:price],
    }[ user.is_pin? && :pin || :package ]
  end
  def binary_bonus
    user.is_binary_bonus_active? && ((user.right_bonus.to_f > user.left_bonus.to_f) && (user.left_bonus.try(:to_f) / 2) || (user.right_bonus.try(:to_f) / 2)) || 0
  end
  def total_income
    user.total_income.try(:to_f) + user.binary_bonus.try(:to_f)
  end
  def total_income_calculate
    if user.re_buy || user.is_package_updated || user.is_package_converted
      amount_calculation_for_xfactor
    else
      total_income
    end
  end
  def amount_calculation_for_xfactor
    if user.binary_bonus_for_xfactor != 0
      user.current_x_factor_income.to_f + user.binary_bonus_for_xfactor.to_f - user.minus_x_factor_binary.to_f
    else
      user.current_x_factor_income.to_f + user.binary_bonus_for_xfactor.to_f
    end
  end
  def can_upgrade_url?(id)
    (_=current_package && _=current_package[:price]) && _ <= FindPackages.new(id).current_package[:price] || false
  end
  # TODO: NOT USING MUST BE REMOVED
  def graph_total_percent_old
    (user.total_income.try(:to_f) + user.binary_bonus.try(:to_f)) / max_package_total_earning * 100
  end
  def graph_total_percent
    (x_factor_graph / max_package_total_earning) * 100
  end
  def x_factor_graph
    if user.re_buy || user.is_package_updated
      amount_calculation_for_xfactor
    elsif user.package_updated_at.present?
      total_income
    else
      user.binary_bonus_for_xfactor.to_f != 0.0 ? user.current_x_factor_income.try(:to_f) + user.binary_bonus_for_xfactor.try(:to_f) - user.minus_x_factor_binary.try(:to_f) : user.current_x_factor_income.try(:to_f) + user.binary_bonus_for_xfactor.try(:to_f)
    end
  end
  delegate :active_job, :active_job?, :doj_update, to: :scheduler_update, prefix: :scheduler, allow_nil: true
  delegate :calculate, :current_rank, to: :cupda, allow_nil: true, prefix: true
  delegate :current_package, to: :find_packages, allow_nil: true
  delegate :package_id, :created_users, :indirect_total_bonus_amount, :indirect_bonus_amount, :left_bonus, :right_bonus, :weekly_roi_to_cash_amount, to: :user, allow_nil: true
end
