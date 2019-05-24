class AddPackageUpdatedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :package_updated_at, :date
  end
end
