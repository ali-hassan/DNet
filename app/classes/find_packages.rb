class FindPackages
  attr_accessor :id
  def initialize(id)
    self.id = id
  end
  def packages
    {
      "package-01": {
        price: 100,
        binary: 24,
        category: "starter",
      },
      "package-02": {
        price: 200,
        binary: 48,
        category: "starter"
      },
      "package-03": {
        price: 300,
        binary: 72,
        category: "starter",
      },
      "package-04": {
        price: 500,
        binary: 120,
        category: "Basic",
      },
      "package-05": {
        price: 1000,
        binary: 240,
        category: "Basic"
      },
      "package-06": {
        price: 2000,
        binary: 480,
        category: 'Advance'
      },
      "package-07": {
        price: 5000,
        binary: 1200,
        category: 'Advance'
      },
      "package-08": {
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
