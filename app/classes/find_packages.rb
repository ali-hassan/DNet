class FindPackages
  attr_accessor :id
  def initialize(id="")
    self.id = id
  end
  def packages
    {
      "100": {
        price: 100,
        binary: 1,
        token: 40000,
        category: "starter",
      },
      "250": {
        price: 250,
        binary: 2,
        token: 100000,
        category: "starter"
      },
      "500": {
        price: 500,
        binary: 3,
        token: 200000,
        category: "starter",
      },
      "700": {
        price: 700,
        binary: 4,
        token: 280000,
        category: "starter",
      },
      "1000": {
        price: 1000,
        binary: 5,
        token: 400000,
        category: "basic",
      },
      "2500": {
        price: 2500,
        binary: 6,
        token: 1000000,
        category: "basic"
      },
      "5000": {
        price: 5000,
        binary: 7,
        token: 2000000,
        category: 'advance'
      },
      "10000": {
        price: 10000,
        binary: 8,
        token: 4000000,
        category: 'advance',
      }
    }.with_indifferent_access
  end
  def current_package
    packages[id]
  end

  def xfactor_amount
    current_package && current_package[:price] * Setting.find_value("default_#{current_package[:category].try(:downcase)}_package_xfactor").try(:value).try(:to_f)
  end
  def current_payment_string
    Rails.application.secrets.bitpay_button_strings[id.gsub("-", "_").to_sym]
  end
end
