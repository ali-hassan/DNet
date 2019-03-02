class AddBinaryBonusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :binary_bonus
  end
end
