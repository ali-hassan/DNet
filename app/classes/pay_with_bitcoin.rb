class PayWithBitcoin
  attr_accessor :user, :package_id
  def initialize(user, package_id)
    self.user, self.package_id = user, package_id
  end
  def package
    @package ||= FindPackages.new(package_id).current_package
  end
  def bit_pay
    @bit_pay ||= BitPayUserAdapter.new(user)
  end
  def gen_url
    if invoice = bit_pay.charge(package["price"])
      user.bit_pay_transactions.create(token: invoice["token"], bitpay_url: invoice["url"]); invoice["url"]
    end
  end
end
