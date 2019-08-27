class AddWalletToWithdrawlRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :withdrawl_requests, :wallet, :string
  end
end
