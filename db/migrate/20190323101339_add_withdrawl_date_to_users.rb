class AddWithdrawlDateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :withdrawl_date, :datetime
  end
end
