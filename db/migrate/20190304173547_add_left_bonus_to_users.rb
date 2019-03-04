class AddLeftBonusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :left_bonus
  end
end
