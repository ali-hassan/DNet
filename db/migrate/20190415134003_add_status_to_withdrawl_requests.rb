class AddStatusToWithdrawlRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :withdrawl_requests, :status, :string, default: 'pending'
  end
end
