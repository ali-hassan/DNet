class AddBinaryBonusForXfactorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :binary_bonus_for_xfactor
  end
end
