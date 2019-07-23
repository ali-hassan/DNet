ActiveAdmin.register User, as: "UserDirectBonus" do
  actions :index, :edit, :update
  permit_params :current_bonus_points

  index do
    column :username
    column :current_bonus_points
    actions
  end
  form do |f|
    f.inputs do
      f.input :current_bonus_points
    end
    actions
  end
end
