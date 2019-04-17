ActiveAdmin.register User, as: "UserWithdrawGateway" do
  actions :index, :edit, :update
  permit_params :withdraw_gateway

  index do
    column :username
    column "Email", :email
    column "Package", :package_id
    column "Withdraw Gateway", :withdraw_gateway
    actions
  end

  form do |f|
    f.inputs do
      f.input :withdraw_gateway, as: :select, collection: ["btc", "perfect_money", "skrill", "payoneer"], prompt: "Withdraw Gateway"
    end
    actions
  end

end
