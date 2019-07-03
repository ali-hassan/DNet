class AddIsPackageConvertedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_package_converted, :boolean, default: false
    User.all.each { |user| user.update binary_bonus_for_xfactor: user.binary_bonus }
  end
end
