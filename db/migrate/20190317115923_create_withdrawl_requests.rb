class CreateWithdrawlRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :withdrawl_requests do |t|
      t.references :user, foreign_key: true
      t.monetize :pts
      t.string :bitcoin_url
      t.boolean :is_clear

      t.timestamps
    end
  end
end
