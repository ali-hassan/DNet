class AddChargePackageBinaryToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :charge_package_binary, :string
  end
end
