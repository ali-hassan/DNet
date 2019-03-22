ActiveAdmin.register UserTransaction, as: "Withdrawal List" do

  index do
    column :username
    column "Sender ID", :user_id
    column "Receiver ID", :receiver_id
    column "Amount", :amount
    column "Wallet type", :wallet_type
    column "Status", :status
    column "Sent date", :created_at
  end
end
