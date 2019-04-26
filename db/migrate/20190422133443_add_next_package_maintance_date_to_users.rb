class AddNextPackageMaintanceDateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :next_package_maintance_date, :date
  end
end
