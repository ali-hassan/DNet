ActiveAdmin.register User, as: "KycApproval" do
  actions :index, :edit, :update
  permit_params :is_valid_kyc
  index do
    column :is_valid_kyc
    column "Email", :email
    column "User Name", :username
    column "Verify Identity" do |user|
      if user.document.url
        image_tag(user.document.url, width: "200px")
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :is_valid_kyc, label: "Approve Identity"
    end
    actions
  end

end
