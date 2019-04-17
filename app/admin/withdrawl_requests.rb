ActiveAdmin.register WithdrawlRequest do 

  index do
    id_column
    column :username do |withdrawl_request|
      withdrawl_request.user.try(:username)
    end
    column :email do |withdrawl_request|
      withdrawl_request.user.try(:email)
    end
    column :pts, "Amount" do |withdrawl_request|
      withdrawl_request.pts.to_f
    end
    column "URL", :bitcoin_url
    column :status
    column :service
    column :amount_before_tax
    column "Tax", :service

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
    column :pts do |withdrawl_request|
      withdrawl_request.pts.to_f
    end
    column :bitcoin_url
    column :status
    column :service
    column :amount_before_tax
    column "Tax", :service
    column :created_at
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :pts, label: 'Amount'
      f.input :bitcoin_url, label: "URL"
      f.input :status, collection: ["pending", "approved", "rejected"]
    end
    actions
  end
end
