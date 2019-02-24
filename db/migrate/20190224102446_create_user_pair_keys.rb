class CreateUserPairKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :user_pair_keys do |t|
      t.integer :admin_user_id
      t.references :user, foreign_key: true
      t.string :key
      t.string :expiration_date
      t.string :token

      t.timestamps
    end
  end
end
