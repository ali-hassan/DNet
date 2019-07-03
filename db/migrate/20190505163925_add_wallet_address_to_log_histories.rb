class AddWalletAddressToLogHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :withdrawl_requests, :wallet_address, :string
  end
end
