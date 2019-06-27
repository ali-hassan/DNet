class BitPayAdminUserAdapter
  attr_accessor :user, :file_path
  def initialize(user)
    self.user, self.file_path = user, Rails.root.join("pem", "bitpay", "admin_usr_#{user.id}")
  end
  def generate_pem_and_store
    pair_data = client.pair_client
    pk = user.user_pair_keys.create(key: pair_data[0]["pairingCode"], expiration_date: pair_data[0]["pairingExpiration"])
    store_pem_file
  end
  def gen_pem
    @gen_pem ||= BitPay::KeyUtils.generate_pem
  end
  def client
    @client ||= BitPay::SDK::Client.new(api_uri: Rails.application.secrets.bitpay_uri, pem: gen_pem)
  end
  def store_pem_file
    FileUtils.mkdir_p(self.file_path); File.write(file_name, gen_pem); file_name.to_s
  end
  def file_name
    file_path.join("key.pem")
  end
  def read_pem
    File.read(self.file_name)
  end
end
