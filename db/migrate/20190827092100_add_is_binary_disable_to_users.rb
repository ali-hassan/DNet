class AddIsBinaryDisableToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_binary_disable, :boolean, default: false
  end
end
