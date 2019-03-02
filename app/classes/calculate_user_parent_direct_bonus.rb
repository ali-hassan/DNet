require 'forwardable'

class CalculateUserParentDirectBonus

  extend Forwardable
  def_delegators :@user, :total_bonus_points, :current_bonus_points, :package_price,
    :created_by, :adapter

  def initialize(user)
    @user = user
  end
  def calculate
    (_ = created_by).present? && (_.update(params); apply_parents_bonus) || false
  end
  def apply_parents_bonus
    alpl { |usr, index| usr && usr.adapter.apply_indirect_bonus_at(index, package_price) }
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
    }
  end
  def current_bonus_val
    (package_price / 100 * 8.0)
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
