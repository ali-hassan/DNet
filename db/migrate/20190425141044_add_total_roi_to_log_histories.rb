class AddTotalRoiToLogHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :log_histories, :total_roi, :string
  end
end
