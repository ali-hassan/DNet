ActiveAdmin.register User, as: "EditPin" do
  permit_params :email, :password, :password_confirmation, :smart_wallet_balance, :total_bonus_points, :indirect_bonus_amount,
                :indirect_total_bonus_amount, :binary_bonus, :total_income, :left_bonus, :right_bonus, :is_binary_bonus_active, :cash_wallet_amount,
                :current_week_roi_amount,
                :total_weekly_percentage_amount,
                :indirect_bonus_amount, :indirect_bonus_users_count, :direct_bonus_users_count

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column "Smart Wizard Balance",  :smart_wallet_balance
    column :is_binary_bonus_active
    # column :current_week_roi_amount
    # column :total_weekly_percentage_amount
    column :indirect_bonus_amount
    column "Pacakage Amount", :package_id
    column "Activation Date", :created_at
    actions
  end

  filter :email
  filter :username
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :is_binary_bonus_active, label: "Binary Check"
      f.input :smart_wallet_balance, label: "Smart Wizard Balance"
      # f.input :direct_bonus_users_count, label: "Direct Bonus"
      # f.input :indirect_bonus_users_count, label: "InDirect Bonus"
      f.input :binary_bonus, label: "Binary Bonus"
      f.input :total_income
      f.input :left_bonus
      f.input :right_bonus
    end
    f.actions
  end

  controller do
    def update
      update! do |format|
        format.html { AdminUser.deduct_amount(resource.smart_wallet_balance); redirect_to([:admin, :users]) } if resource.valid?
      end
    end
    def scoped_collection
      User.where(is_pin: true)
    end
  end
end
