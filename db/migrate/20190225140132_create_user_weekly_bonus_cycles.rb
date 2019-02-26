class CreateUserWeeklyBonusCycles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_weekly_bonus_cycles do |t|
      t.references :user, foreign_key: true
      t.string :current_cycle
      t.string :plan_id
      t.monetize :amount

      t.timestamps
    end
  end
end
