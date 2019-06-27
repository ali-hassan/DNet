class AddEncryptedPinIvToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encrypted_pin_iv, :string
  end
end
