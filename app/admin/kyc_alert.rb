ActiveAdmin.register KycAlert, as: "KycAlert" do
  actions :index, :destroy
  # permit_params :is_valid_kyc, :reject_kyc
  preserve_default_filters!
  filter :user_username, as: :string
  filter :user_email, as: :string

  index do
    # column :is_valid_kyc
    # column :reject_kyc
    column "Email" do |kyc|
      kyc.user.email
    end
    column "User Name" do |kyc|
      kyc.user.username
    end
    column "KYC Date", :created_at
    column "Verify Identity" do |kyc|
      if kyc.user.document.url
        image_tag(kyc.user.document.url, width: "200px")
      end
    end
    actions
  end

  # form do |f|
  #   f.inputs do
  #     f.input :is_valid_kyc, label: "Approve Identity"
  #     f.input :reject_kyc, label: "Reject Identity"
  #   end
  #   actions
  # end

end
