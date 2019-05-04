ActiveAdmin.register User, as: "RoiReport" do
  preserve_default_filters!
  filter :username, as: :string
  filter :email, as: :string

  actions :index

  index do
    id_column
    column :full_name
    column :email
    column :username
    column :package_id
    column :active_date do |user|
      user.package_activation
    end
    column :weekly_roi do |user|
      user.current_week_roi_amount
    end
    column :total_roi do |user|
      user.total_weekly_percentage_amount.try(:to_f)
    end
    column :roi_balance do |user|
      user.current_total_weekly_roi_amount.try(:to_f)
    end
    column :total_income
    column :created_at
  end

  csv do
    column :id
    column :full_name
    column :email
    column :username
    column :package_id
    column :active_date do |user|
      user.package_activation
    end
    column :weekly_roi do |user|
      user.current_week_roi_amount
    end
    column :total_roi do |user|
      user.total_weekly_percentage_amount.try(:to_f)
    end
    column :roi_balance do |user|
      user.current_total_weekly_roi_amount.try(:to_f)
    end
    column :total_income
    column :created_at
  end

  controller do
    def scoped_collection
      User.where("package_id IS NOT NULL")
    end
  end
end
