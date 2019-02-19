class AddPackageIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :package_id, :string
  end
end
