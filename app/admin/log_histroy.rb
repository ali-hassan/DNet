ActiveAdmin.register LogHistory do
  preserve_default_filters!
  filter :user_username, as: :string
  filter :user_email, as: :string
  actions :index, :show

end
