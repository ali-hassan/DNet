require 'forwardable'

class CalculateUserParentDirectBonus

  extend Forwardable
  def_delegators :@user, :total_bonus_points, :current_bonus_points,
    :created_by, :adapter, :parent_position

  def initialize(user)
    @user = user
    user.is_pin? && ignore_list.push(user.parent_id)
  end
  def package_price
    @user.charge_package_price.try(:to_f)
  end
  def calculate
    (_ = created_by).present? && (calculate_direct_bonus(_); apply_parents_bonus) || false
  end
  def calculate_direct_bonus(usr)
    usr.adapter.perform_weekly_count.calculate_condition && (usr.update(params) && created_by.log_histories.create(logable: @user, message: "Direct bonus #{current_bonus_val} on #{@user.username} for package #{package_price.to_f}", log_type: "direct_bonus"))
  end
  def apply_parents_bonus
    alpl { |usr, index| usr && usr.adapter.apply_indirect_bonus_at(index, package_price, @user) }; calculate_binary_bonus
  end
  def calculate_binary_bonus
    cal_bb(adapter.parent_lists, parent_position, current_binary)
  end
  def current_binary
    @user.charge_package_binary.try(:to_f)
  end
  def cal_bb(pl, position, binary, index=0)
    (usr=pl[index]).present? && (calcu_ulb(usr, position, binary); cal_bb(pl, usr.parent_position, binary, index+1)) || true
  end
  def cal_bb_condition?(usr)
    child_condition?(usr, "left") && child_condition?(usr, "right")
  end
  def child_condition?(usr, position)
    (ch = usr.children.where(parent_position: position).first) && (ch.adapter.find_child_list_by_parent_id.map { |umt| umt.package_id.present? && umt.created_by_id == usr.id }.include?(true) || (ch.package_id.present? && ch.created_by_id == usr.id))
  end
  def ignore_list
    @ignore_list ||= Array.new
  end
  def calcu_ulb(usr,position, binary)
    if usr.adapter.perform_weekly_count
      usr.attributes = calculate_leg_bonus(usr, position, binary)
      usr.binary_bonus, usr.is_binary_bonus_active = usr.adapter.calculate_binary_bonus, cal_bb_condition?(usr)
      usr.cash_wallet_amount = usr.cash_wallet_amount.try(:to_f) + usr.adapter.calculate_binary_bonus
      ignore_list.include?(usr.id) && usr.is_binary_bonus_active = false
      usr.is_binary_bonus_active? && usr.adapter.cupda.check_for_rank_upgrade
      usr.log_histories.create(logable: @user, message: "Binary Points #{binary} of user #{@user.username} for package #{@user.package_price.to_f}", log_type: "binary_bonus")
      usr.save(validate: false)
    end
  end
  def alpl(&block)
    adapter.linked_parent_list.values_at(1, 2, 3, 4, 5, 6).each.with_index(&block)
  end
  def params
    {
      current_bonus_points: current_bonus_points_sum,
      total_bonus_points: total_bonus_points_sum,
      smart_wallet_balance: smart_wallet_balance_sum,
      binary_bonus: bonus_wallet_sum,
      total_income: total_income_sum,
      cash_wallet_amount: total_cash_wallet_amount,
    }
  end

  def calculate_leg_bonus(usr, position, binary)
    { (_ = "#{position}_bonus") => usr.send(_).try(:to_f) + binary }
  end
  def current_bonus_val
    (package_price / 100 * 8.0)
  end
  def total_income_sum
    created_by.total_income.try(:to_f) + current_bonus_val
  end
  def total_cash_wallet_amount
    created_by.cash_wallet_amount.try(:to_f) + current_bonus_val # + adapter.calculate_binary_bonus
  end
  def bonus_wallet_sum
    created_by.binary_bonus.try(:to_f) + current_binary 
  end
  def current_bonus_points_sum
    created_by.current_bonus_points.try(:to_f) + current_bonus_val
  end
  def total_bonus_points_sum
    created_by.total_bonus_points.try(:to_f) + current_bonus_val.try(:to_f)
  end
  def rank_list
    {
      0..2499 => rank_obj.new("Not Assigned", "", 2500),
      2500..6999 => rank_obj.new("Bronze", "pin", 7000),
      7000..13999 => rank_obj.new("Silver", "500", 14000),
      14000..69999 => rank_obj.new("Gold", "1000", 70000),
      70000..139999 => rank_obj.new("Ruby", "5000", 140000),
      140000..299999 => rank_obj.new("Emerald", "10000", 300000),
      300000..699999 => rank_obj.new("Diamond", "20000", 700000),
      700000..1399999 => rank_obj.new("Director", "50000", 1400000),
      1400000..9999999 => rank_obj.new("Ambassador", "10000", 99999),
    }
  end
  def current_rank
    rank_list.select { |rnk| rnk === calculate_rank.to_i }.values.first
  end
  def calculate_rank
    (@user.right_bonus.to_f > @user.left_bonus.to_f) && @user.right_bonus || @user.left_bonus
  end
  def rank_obj
    @rank_obj ||= Struct.new(:name, :reward, :cap)
  end
  def smart_wallet_balance_sum
    created_by.try(:smart_wallet_balance).try(:to_f)
  end
  def check_for_rank_upgrade
    (@user.current_rank != current_rank.reward) && log_reward_history(current_rank.reward)
  end
  def log_reward_history(reward)
    @user.current_reward = reward
    @user.log_histories.build(logable: @user, message: "You earn #{reward} ", log_type: 'user_reward')
    !["", "pin"].include?(reward) && @user.update(smart_wallet_balance: smart_wallet_balance.to_f + reward.to_f) || 0
  end
  def ca(reward)
    log_reward_history(reward)
  end
end
