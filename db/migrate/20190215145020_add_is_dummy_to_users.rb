class AddIsDummyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_dummy, :boolean, default: false
  end
end
