class AddCurrentPackageIterationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_package_iteration, :integer, default: 0
  end
end
