class AddMinusXFactorBinary < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :minus_x_factor_binary
  end
end
