class AddCurrentBonusPointsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_bonus_points, :string, default: 0
  end
end
