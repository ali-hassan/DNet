class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :father_name, :string
    add_column :users, :document, :string
    add_column :users, :address, :string
    add_column :users, :gender, :string
    add_column :users, :zipcode, :string
  end
end
