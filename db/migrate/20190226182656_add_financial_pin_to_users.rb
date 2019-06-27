class AddFinancialPinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :financial_pin, :string
    add_column :users, :current_financial_pin, :string
  end
end
