class AddCurrentTotalWeeklyRoiToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :current_total_weekly_roi_amount
  end
end
