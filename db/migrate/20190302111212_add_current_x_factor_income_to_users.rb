class AddCurrentXFactorIncomeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :current_x_factor_income
  end
end
