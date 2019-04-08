class CreateActivateUserPackages < ActiveRecord::Migration[5.1]
  def change
    create_table :activate_user_packages do |t|
      t.references :user, foreign_key: true
      t.string :package_id

      t.timestamps
    end
  end
end
