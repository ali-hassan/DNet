class AddAdminBalanceCentsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :admin_balance
  end
end
