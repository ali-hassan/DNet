ActiveAdmin.register User, as: "CurrentWeekPayment" do
  actions :index, :edit, :update
  permit_params :current_total_weekly_roi_amount, :total_weekly_percentage_amount, :current_week_roi_amount, :total_income, :current_x_factor_income
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
      f.input :current_total_weekly_roi_amount, label:  "Current ROI Balance"
      f.input :total_weekly_percentage_amount, label: "Total ROI"
      f.input :current_week_roi_amount, label: "Weekly ROI"
      f.input :total_income
      f.input :current_x_factor_income
    end
    actions
  end

end
