class AddIsBinaryBonusActiveToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_binary_bonus_active, :boolean, default: false
  end
end
