ActiveAdmin.register User, as: "UserInDirectBonus" do
  actions :index, :edit, :update
  permit_params :indirect_bonus_amount

  index do
    column :username
    column :indirect_bonus_amount
    actions
  end
  form do |f|
    f.inputs do
      f.input :indirect_bonus_amount
    end
    actions
  end
end
