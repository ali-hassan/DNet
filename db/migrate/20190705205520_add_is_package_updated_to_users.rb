class AddIsPackageUpdatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_package_updated, :boolean, default: false
  end
end
