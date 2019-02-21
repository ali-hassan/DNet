class ChargeAmountAtA
  attr_accessor :user, :package_id
  def initialize(user, package_id)
    self.user, self.package_id = user, package_id
  end
  def package
    @package ||= FindPackages.new(package_id).current_package
  end
  def charge!
    update(smart_wallet_balance: smart_wallet_balance.try(:to_f) - package[:price], package_id: package_id)
    AdminUser.add_amount(package[:price])
  end
  delegate :update, :smart_wallet_balance, to: :user, allow_nil: true
end