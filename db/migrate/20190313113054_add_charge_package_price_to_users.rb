class AddChargePackagePriceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :charge_package_price
  end
end
