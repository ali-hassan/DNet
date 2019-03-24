class AddWithdrawGatewayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :withdraw_gateway, :string
  end
end
