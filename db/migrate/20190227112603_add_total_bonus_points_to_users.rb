class AddTotalBonusPointsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :total_bonus_points, :string, default: 0
  end
end
