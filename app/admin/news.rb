ActiveAdmin.register News do
  permit_params :title, :body, :is_active
  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :ckeditor
      f.input :is_active
    end
    actions
  end
end
