class AddBonusWalletCentsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :bonus_wallet
  end
end
