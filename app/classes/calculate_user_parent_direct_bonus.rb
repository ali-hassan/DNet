require 'forwardable'

class CalculateUserParentDirectBonus

  extend Forwardable
  def_delegators :@user, :total_bonus_points, :current_bonus_points, :package_price,
    :created_by, :adapter, :parent_position

  def initialize(user)
    @user = user
    user.is_pin? && ignore_list.push(user.parent_id)
  end
  def calculate
    (_ = created_by).present? && (_.update(params); apply_parents_bonus) || false
  end
  def apply_parents_bonus
    alpl { |usr, index| usr && usr.adapter.apply_indirect_bonus_at(index, package_price) }; calculate_binary_bonus
  end
  def calculate_binary_bonus
    cal_bb(adapter.parent_lists, parent_position, adapter.current_package[:binary])
  end
  def cal_bb(pl, position, binary, index=0)
    (usr=pl[index]).present? && (calcu_ulb(usr, position, binary); cal_bb(pl, usr.parent_position, binary, index+1)) || true
  end
  def cal_bb_condition?(usr)
    child_condition?(usr, "left") && child_condition?(usr, "right")
  end
  def child_condition?(usr, position)
    ((ch = usr.children.where(parent_position: position).first) && (ch.adapter.find_child_list_by_parent_id.map(&:created_by_id).include?(usr.id)))
  end
  def ignore_list
    @ignore_list ||= Array.new
  end
  def calcu_ulb(usr,position, binary)
    if !ignore_list.include?(usr.id)
      usr.attributes = calculate_leg_bonus(usr, position, binary)
      usr.binary_bonus, usr.is_binary_bonus_active = usr.adapter.calculate_binary_bonus, cal_bb_condition?(usr)
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
  def bonus_wallet_sum
    created_by.binary_bonus.try(:to_f) + adapter.find_packages.current_package[:binary]
  end
  def current_bonus_points_sum
    created_by.current_bonus_points.try(:to_f) + current_bonus_val
  end
  def total_bonus_points_sum
    created_by.total_bonus_points.try(:to_f) + current_bonus_val.try(:to_f)
  end
  def rank_list
    {
      0..2499 => rank_obj.new("", "", 2500),
      2500..6999 => rank_obj.new("bronze", "pin", 7000),
      7000..13999 => rank_obj.new("silver", "500", 14000),
      14000..69999 => rank_obj.new("gold", "1000", 70000),
      70000..139999 => rank_obj.new("ruby", "5000", 140000),
      140000..299999 => rank_obj.new("emerald", "10000", 300000),
      300000..699999 => rank_obj.new("diamond", "20000", 700000),
      700000..1399999 => rank_obj.new("director", "50000", 1400000),
      1400000..9999999 => rank_obj.new("ambassador", "10000", 99999),
    }
  end
  def current_rank
    rank_list.select { |rnk| rnk === total_bonus_points.to_i }.values.first
  end
  def rank_obj
    @rank_obj ||= Struct.new(:name, :reward, :cap)
  end
  def smart_wallet_balance_sum
    !["", "pin"].include?(_=current_rank.try(:reward)) && ca(_) || 0
  end
  def ca(amount)
    created_by.present? && (created_by.smart_wallet_balance.to_f + amount.to_f) || 0
  end
end
