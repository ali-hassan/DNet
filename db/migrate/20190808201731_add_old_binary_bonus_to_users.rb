class AddOldBinaryBonusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :old_binary_bonus
    User.all.each{ |usr| usr.update old_binary_bonus_cents: usr.adapter.binary_bonus }
  end
end
