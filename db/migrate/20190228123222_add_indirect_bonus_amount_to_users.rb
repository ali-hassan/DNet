class AddIndirectBonusAmountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :indirect_bonus_amount
  end
end
