class AddRejectKycToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reject_kyc, :boolean, default: false
  end
end
