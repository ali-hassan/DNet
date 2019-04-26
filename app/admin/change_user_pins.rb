ActiveAdmin.register User, as: "ChangeUserPin" do
  actions :index, :edit, :update
  permit_params :pin
  index do
    id_column
    column :username
    actions
  end
  form do |f|
    f.inputs do
      f.input :pin
    end
    f.actions
  end
end
