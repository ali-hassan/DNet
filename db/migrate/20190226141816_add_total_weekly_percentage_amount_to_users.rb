class AddTotalWeeklyPercentageAmountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :total_weekly_percentage_amount
  end
end
