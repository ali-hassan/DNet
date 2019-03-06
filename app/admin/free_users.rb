ActiveAdmin.register User, as: 'FreeUser' do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :is_pin,
    :username, :smart_wallet_balance, :parent_id, :pin_capacity, :parent_position, :fit_user, :total_bonus_points, :indirect_bonus_amount,
                :indirect_total_bonus_amount, :binary_bonus, :total_income, :left_bonus, :right_bonus, :cash_wallet_total
  form do |f|
    f.inputs do
      f.hidden_field :is_pin, value: true
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :pin_capacity, label: "Pin Capacity", as: :select, collection: ["100$", "200$", "300$", "500$", "1000$", "2000$", "5000$", "10000$"], :prompt => "Select Pin Capacity"
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :smart_wallet_balance
      f.input :total_bonus_points
      f.input :indirect_bonus_amount
      f.input :indirect_total_bonus_amount
      f.input :binary_bonus
      f.input :total_income
      f.input :left_bonus
      f.input :right_bonus
      f.input :cash_wallet_total
      f.input :fit_user, :label => 'Sponsor', :as => :select, :collection => User.all.map{|u| [u.username, u.id]}, :prompt => "Select Sponsor"
      f.input :parent_position, :label => 'Position', :as => :select, :collection => [["Right", "right"], ["Left", "left"]], :prompt => "Select position"
    end

    f.actions
  end
  controller do
    def scoped_collection
      User.where(is_pin: true)
    end
  end
end
