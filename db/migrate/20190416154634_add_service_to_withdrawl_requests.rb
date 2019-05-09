class AddServiceToWithdrawlRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :withdrawl_requests, :service, :string
  end
end
