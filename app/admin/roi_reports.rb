ActiveAdmin.register LogHistory, as: "RoiReport" do
  actions :index
  index do
    id_column
    column :full_name do |user_log|
      user_log.user.full_name
    end
    column :email do |user_log|
      user_log.user.email
    end
    column :username do |user_log|
      user_log.user.username
    end
    column :package_id do |user_log|
      user_log.user.package_id
    end
    column :active_date do |user_log|
      user_log.user.created_at.to_date
    end
    column :weekly_roi do |user_log|
      user_log.weekly_roi || user_log.message.split(" ")[2]
    end
    column :total_roi
    column :roi_balance
    column :total_income
    column :created_at
  end
  controller do
    def scoped_collection
      LogHistory.where(log_type: "weekly_roi")
    end
  end
end
