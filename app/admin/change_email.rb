ActiveAdmin.register User, as: "ChangeEmail" do
  actions :index, :edit, :update
  permit_params :email
  index do
    column :username
    column "Email", :email
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
    end
    actions
  end

end
