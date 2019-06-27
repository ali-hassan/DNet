class AddCashWalletAmountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :cash_wallet_amount
  end
end
