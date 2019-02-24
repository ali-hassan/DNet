class CreateBitPayTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :bit_pay_transactions do |t|
      t.text :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
