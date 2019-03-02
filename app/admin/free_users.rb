ActiveAdmin.register User, as: 'FreeUser' do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :is_pin,
    :username, :smart_wallet_balance, :parent_id, :pin_capacity
  form do |f|
    f.inputs do
      f.hidden_field :is_pin, value: true
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :pin_capacity, label: "Pin Balance"
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :parent_id, :label => 'Sponsor', :as => :select, :collection => User.where(is_pin: true).map{|u| [u.full_name, u.id]}, :prompt => "Select Sponsor"
    end

    f.actions
  end
  controller do
    def scoped_collection
      User.where(is_pin: true)
    end
  end
end
