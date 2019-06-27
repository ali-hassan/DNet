class AddTotalIncomeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :total_income
  end
end
