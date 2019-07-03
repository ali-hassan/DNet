class CreateKycAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :kyc_alerts do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
