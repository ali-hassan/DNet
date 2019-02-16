class AddIsPackageActivatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_package_activated, :boolean, default: false
  end
end
