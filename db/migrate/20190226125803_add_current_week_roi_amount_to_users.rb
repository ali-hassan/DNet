class AddCurrentWeekRoiAmountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :current_week_roi_amount
  end
end
