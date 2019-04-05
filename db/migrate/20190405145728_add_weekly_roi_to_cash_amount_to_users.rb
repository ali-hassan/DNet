class AddWeeklyRoiToCashAmountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :weekly_roi_to_cash_amount
  end
end
