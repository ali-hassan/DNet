class AddRoiBalanceToLogHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :log_histories, :roi_balance, :string
  end
end
