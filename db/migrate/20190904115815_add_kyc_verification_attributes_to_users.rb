class AddKycVerificationAttributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :document_front, :string
    add_column :users, :document_back, :string
    add_column :users, :identity_type, :string
  end
end
