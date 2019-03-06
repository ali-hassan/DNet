class FindPackages
  attr_accessor :id
  def initialize(id)
    self.id = id
  end
  def packages
    {
      "100": {
        price: 100,
        binary: 24,
        category: "starter",
      },
      "200": {
        price: 200,
        binary: 48,
        category: "starter"
      },
      "300": {
        price: 300,
        binary: 72,
        category: "starter",
      },
      "500": {
        price: 500,
        binary: 120,
        category: "Basic",
      },
      "1000": {
        price: 1000,
        binary: 240,
        category: "Basic"
      },
      "2000": {
        price: 2000,
        binary: 480,
        category: 'Advance'
      },
      "5000": {
        price: 5000,
        binary: 1200,
        category: 'Advance'
      },
      "10000": {
        price: 10000,
        binary: 2400,
        category: 'Advance',
      }
    }.with_indifferent_access
  end
  def current_package
    packages[id]
  end

  def xfactor_amount
    current_package[:price] * Setting.find_value("default_#{current_package[:category].try(:downcase)}_package_xfactor").try(:value).try(:to_f)
  end
  def current_payment_string
    Rails.application.secrets.bitpay_button_strings[id.gsub("-", "_").to_sym]
  end
end
