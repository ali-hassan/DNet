class AddEncryptedPinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encrypted_pin, :string
  end
end
