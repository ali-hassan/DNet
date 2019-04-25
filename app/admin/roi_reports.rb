ActiveAdmin.register LogHistory, as: "RoiReport" do
  actions :index
  index do
    id_column
    column :user
    column :message
    column :created_at
    column :user_dashboard_smart_wallet_balance do |user_log|
      user_log.user.smart_wallet_balance.try(:to_f)
    end
    column :user_dashboard_binary_bonus do |user_log|
      user_log.user.binary_bonus
    end
    column :user_dashboard_current_roi_balance do |user_log|
      user_log.user.current_total_weekly_roi_amount.try(:to_f)
    end
    column :user_dashboard_total_income do |user_log|
      user_log.user.total_income.try(:to_f)
    end
  end
  controller do
    def scoped_collection
      UserLog.where(log_type: "weekly_roi")
    end
  end
end
