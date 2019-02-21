ActiveAdmin.register User, as: 'FreeUser' do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :is_pin,
    :username, :smart_wallet_balance
  form do |f|
    f.inputs do
      f.hidden_field :is_pin, value: true
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :smart_wallet_balance, label: "Smart Wizard Balance"
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
  controller do
    def scoped_collection
      User.where(is_pin: true)
    end
  end
end