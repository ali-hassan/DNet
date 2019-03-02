class ChargeAmountAtA
  attr_accessor :user, :package_id
  def initialize(user, package_id)
    self.user, self.package_id = user, package_id
  end
  def package
    @package ||= FindPackages.new(package_id).current_package
  end
  def charge!
    update(smart_wallet_balance: smart_wallet_balance.try(:to_f) - deducation_amount,
           package_id: package_id)
    update(current_weekly_percentage: weekly_percentage)
    User.add_amount(deducation_amount)
    calculate_weekly_bonus_cycle!
    user.adapter.cupda_calculate
  end
  def deducation_amount
    package[:price] + package_activation_fees
  end
  def weekly_percentage
    Setting.find_value("default_weekly_#{user.reload.current_package["category"].try(:downcase)}_%").try(:value)
  end
  def calculate_weekly_bonus_cycle!
    user.earn_weekly_point
  end
  def package_activation_fees
    25
  end
  delegate :update, :smart_wallet_balance, :weekly_bonus_cycles, :current_package, to: :user, allow_nil: true
end
