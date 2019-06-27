class BitPayUserAdapter
  attr_accessor :user
  def initialize(user)
    self.user = user
  end
  def charge(amount, currency="USD")
    client.create_invoice(price: amount, currency: currency)
  end
  def client
    @client ||= BitPay::SDK::Client.new(api_uri: Rails.application.secrets.bitpay_uri,
                                        pem: AdminUser.first.bit_pay.read_pem)
  end
end
