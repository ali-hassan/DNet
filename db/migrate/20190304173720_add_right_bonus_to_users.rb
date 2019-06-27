class AddRightBonusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :right_bonus
  end
end
