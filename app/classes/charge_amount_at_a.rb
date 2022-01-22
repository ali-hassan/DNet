class ChargeAmountAtA
  attr_accessor :user, :package_id, :upgrade, :allow_deducation
  def initialize(user, package_id, upgrade, allow_deducation=true)
    self.user, self.package_id, self.upgrade, self.allow_deducation = user, package_id, upgrade, allow_deducation
  end
  def package
    @package ||= FindPackages.new(package_id).current_package
  end
  def token
    @token ||= package[:token]
  end
  def charge!
    user.update(token_count: token.to_i+user.token_count.to_i)
    ### Below are commented as not maintained or supported anymore
    update(params)
    # update(current_weekly_percentage: weekly_percentage)
    User.add_amount(deducation_amount)
    # calculate_weekly_bonus_cycle!
    User.find(user.id).adapter.cupda_calculate
    ### Above are commented as not maintained or supported anymore
    # update(reset_params)
  end
  def reset_params
    {
      binary_bonus_for_xfactor: 0,
      current_x_factor_income: 0,
    }
  end
  def params
    {
      package_activation_date: DateTime.now,
      next_package_maintance_date: DateTime.now + 1.month,
      package_id: package_id,
      current_x_factor_income: current_x_factor_income_count,
      current_package_iteration: 50,
      charge_package_price: package_price,
      charge_package_binary: current_binary,
    }.merge(self.allow_deducation ? {smart_wallet_balance: smart_wallet_balance.try(:to_f) - deducation_amount} : {}).merge(
      self.upgrade ? { package_updated_at: DateTime.now } : {}
     )
  end
  def current_x_factor_income_count
    upgrade && user.current_x_factor_income.to_f || 0
  end
  def deducation_amount
    package_price #+ package_activation_fees
  end
  def current_binary
    package[:binary] - (upgrade && user.current_package[:binary] || 0)
  end
  def package_price
    package[:price] - (upgrade && user.current_package[:price] || 0)
  end
  def weekly_percentage
    Setting.find_value("default_weekly_#{package["category"].try(:downcase)}_%").try(:value)
  end
  def calculate_weekly_bonus_cycle!
    # After 2 weeks it will be started ROI - first phase
    user.adapter.scheduler_doj_update(upgrade && 2.weeks.from_now || 2.weeks)
  end
  def package_activation_fees
    upgrade && 0 || 25
  end
  delegate :update, :smart_wallet_balance, :weekly_bonus_cycles, :current_package, to: :user, allow_nil: true
end
