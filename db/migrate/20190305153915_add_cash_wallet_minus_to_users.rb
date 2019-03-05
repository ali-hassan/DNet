class AddCashWalletMinusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :cash_wallet_minus
  end
end
