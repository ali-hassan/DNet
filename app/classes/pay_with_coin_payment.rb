class PayWithCoinPayment
  attr_accessor :package, :user
  def initialize(user, package_id)
    self.user, self.package = user, FindPackages.new(package_id).current_package
    self.user.package_id = package_id
  end

  def gen_url
    @gen_url ||= Coinpayments.create_transaction(user.adapter.package_price, "USD", "BTC", { buyer_email: user.email })
  end
end
