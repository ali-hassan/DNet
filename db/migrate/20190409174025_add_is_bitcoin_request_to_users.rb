class AddIsBitcoinRequestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_bitcoin_request, :boolean, default: false
  end
end
