class AddBitpayUrlToBitPayTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :bit_pay_transactions, :bitpay_url, :string
  end
end
