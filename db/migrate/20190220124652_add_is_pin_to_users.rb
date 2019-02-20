class AddIsPinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_pin, :boolean, default: false
  end
end
