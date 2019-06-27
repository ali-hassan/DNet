class AddIndirectTotalBonusAmountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :indirect_total_bonus_amount
  end
end
