ActiveAdmin.register LogHistory do
  preserve_default_filters!
  filter :user_username, as: :string
  filter :user_email, as: :string
  actions :index, :show

  index  do
    id_column
    column "User" do |log|
      auto_link log.user
    end
    column "User ID" do |log|
      log.user.id
    end
    column "User Name" do |log|
      log.user.id
    end
    column "Email" do |log|
      log.user.email
    end
    column :package_id
    column :weekly_roi
    column :total_roi
    column :roi_balance
    column :total_income
    column :message
    column :logable_type
    column :logable_id
    column :log_type
  end
end
