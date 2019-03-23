class AddIsValidKycToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_valid_kyc, :boolean, default: false
  end
end
