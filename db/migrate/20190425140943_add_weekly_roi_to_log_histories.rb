class AddWeeklyRoiToLogHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :log_histories, :weekly_roi, :string
  end
end
