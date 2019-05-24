class AddTotalIncomeToLogHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :log_histories, :total_income, :string
  end
end
