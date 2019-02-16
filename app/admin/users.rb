ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :smart_wallet_balance

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column "Smart Wizzard Balance",  :smart_wallet_balance_cents_cents
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :smart_wallet_balance_cents_cents, label: "Smart Wizzard Balance"
    end
    f.actions
  end

end
