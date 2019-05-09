class PayWithCoinPayment
  attr_accessor :package, :user
  def initialize(user, package_id)
    self.user, self.package = user, FindPackages.new(package_id).current_package
    self.user.package_id = package_id
    #user.update charge_package_price: package_id.to_f
    User.find_by(id: self.user.id).update(is_bitcoin_request: true)
  end

  def gen_url
    @gen_url ||= Coinpayments.create_transaction(user.package_id.to_i + 25, "USD", "BTC", { buyer_email: user.email })
  end
end
