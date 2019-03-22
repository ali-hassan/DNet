ActiveAdmin.register User, as: "CurrentWeekPayment" do
  actions :index, :edit, :update
  permit_params :current_total_weekly_roi_amount, :total_weekly_percentage_amount, :current_week_roi_amount
  index do
    column :username
    column "Email", :email
    column "Package", :package_id
    column "Current ROI Balance", :current_total_weekly_roi_amount
    column "Total ROI", :total_weekly_percentage_amount
    column "Weekly ROI", :current_week_roi_amount
    actions
  end

  form do |f|
    f.inputs do
      f.input :current_total_weekly_roi_amount
      f.input :total_weekly_percentage_amount
      f.input :current_week_roi_amount
    end
    actions
  end

end
