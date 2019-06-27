class AddCurrentWeeklyPercentageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_weekly_percentage, :float
  end
end
