class AddSmartWalletBalanceCentsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :smart_wallet_balance
  end
end
