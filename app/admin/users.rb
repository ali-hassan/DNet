ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :smart_wallet_balance

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column "Smart Wizard Balance",  :smart_wallet_balance
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :smart_wallet_balance, label: "Smart Wizard Balance"
    end
    f.actions
  end

  controller do
    def update
      update! do |format|
        format.html { AdminUser.deduct_amount(resource.smart_wallet_balance); redirect_to([:admin, :users]) } if resource.valid?
      end
    end
  end
end
