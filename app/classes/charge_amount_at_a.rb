class ChargeAmountAtA
  attr_accessor :user, :package_id, :upgrade
  def initialize(user, package_id, upgrade)
    self.user, self.package_id, self.upgrade = user, package_id, upgrade
  end
  def package
    @package ||= FindPackages.new(package_id).current_package
  end
  def charge!
    update(params)
    update(current_weekly_percentage: weekly_percentage)
    User.add_amount(deducation_amount)
    calculate_weekly_bonus_cycle!
    User.find(user.id).adapter.cupda_calculate
  end
  def params
    {
      smart_wallet_balance: smart_wallet_balance.try(:to_f) - deducation_amount,
      package_id: package_id,
      current_x_factor_income: current_x_factor_income_count,
      current_package_iteration: 50,
      charge_package_price: package_price,
      charge_package_binary: current_binary,
    }
  end
  def current_x_factor_income_count
    upgrade && user.current_x_factor_income.to_f || 0
  end
  def deducation_amount
    package_price + package_activation_fees
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
    WeeklyPlanBonusWorker.perform_in(2.minutes.from_now, {user_id: @user.id})
  end
  def package_activation_fees
    upgrade && 0 || 25
  end
  delegate :update, :smart_wallet_balance, :weekly_bonus_cycles, :current_package, to: :user, allow_nil: true
end
