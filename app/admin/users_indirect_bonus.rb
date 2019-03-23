ActiveAdmin.register User, as: "UserInDirectBonus" do
  actions :index, :edit, :update

  index do
    column :username
    column :indirect_bonus_users_count
    actions
  end
  form do |f|
    f.inputs do
      f.input :indirect_bonus_users_count
    end
    actions
  end
end
