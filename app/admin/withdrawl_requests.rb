ActiveAdmin.register WithdrawlRequest do 

  index do
    id_column
    column :username do |withdrawl_request|
      withdrawl_request.user.try(:username)
    end
    column :email do |withdrawl_request|
      withdrawl_request.user.try(:email)
    end
    column "Total Chargeable Amount", :pts do |withdrawl_request|
      withdrawl_request.pts.to_f
    end

    column "Gateway" do |withdrawl_request|
      withdrawl_request.user.withdraw_gateway
    end

    column "URL", :bitcoin_url
    column "Transferable Amount", :amount_before_tax
    column "Tax", :service
    column :status

    column 'Date', :created_at
    actions
  end

  csv do
    column :id
    column :username do |withdrawl_request|
      withdrawl_request.user.try(:username)
    end
    column :email do |withdrawl_request|
      withdrawl_request.user.try(:email)
    end
    column "Total Chargeable Amount" do |withdrawl_request|
      withdrawl_request.pts.to_f
    end

    column "Gateway" do |withdrawl_request|
      withdrawl_request.user.withdraw_gateway
    end

    column "URL" do |withdrawl_request|
      withdrawl_request.bitcoin_url
    end
    column "Transferable Amount" do |withdrawl_request|
      withdrawl_request.amount_before_tax
    end
    column "Tax" do |withdrawl_request|
      withdrawl_request.service
    end
    column :status

    column 'Date' do |withdrawl_request|
      withdrawl_request.created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :pts, label: 'Amount'
      f.input :status, collection: ["pending", "approved", "rejected"]
    end
    actions
  end
end
