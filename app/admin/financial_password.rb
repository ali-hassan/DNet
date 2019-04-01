ActiveAdmin.register User, as: "EditFinancialPassword" do
  permit_params :pin

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :pin
    actions
  end

  filter :email
  filter :username
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :pin
    end
    f.actions
  end
end
