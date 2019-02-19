class FindPackages
  attr_accessor :id
  def initialize(id)
    self.id = id
  end
  def packages
    {
      "package-01": {
        price: 500,
        binary: 120,
        category: "Basic",
      },
      "package-02": {
        price: 1000,
        binary: 240,
        category: "Basic"
      },
      "package-03": {
        price: 2000,
        binary: 480,
        category: "Advance",
      },
      "package-04": {
        price: 5000,
        binary: 1200,
        category: "Advance",
      },
      "package-05": {
        price: 10000,
        binary: 2400,
        category: "Advance"
      },
    }.with_indifferent_access
  end
  def current_package
    packages[id]
  end
end
