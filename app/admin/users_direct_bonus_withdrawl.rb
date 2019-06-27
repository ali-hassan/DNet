ActiveAdmin.register User, as: "UserDirectBonus" do
  actions :index, :edit, :update

  index do
    column :username
    column :direct_bonus_users_count
    actions
  end
  form do |f|
    f.inputs do
      f.input :direct_bonus_users_count
    end
    actions
  end
end
