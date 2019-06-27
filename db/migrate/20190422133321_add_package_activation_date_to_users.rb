class AddPackageActivationDateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :package_activation_date, :date
  end
end
