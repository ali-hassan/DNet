class AddBonusCycleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bonus_cycle, :string
  end
end
