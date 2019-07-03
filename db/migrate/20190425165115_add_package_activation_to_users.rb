class AddPackageActivationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :package_activation, :date
  end
end
