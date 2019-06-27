class CreateUserTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_transactions do |t|
      t.references :user, foreign_key: true
      t.integer :receiver_id
      t.monetize :amount
      t.string :wallet_type

      t.timestamps
    end
  end
end
