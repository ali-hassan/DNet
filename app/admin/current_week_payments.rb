ActiveAdmin.register User, as: "CurrentWeekPayment" do
  actions :index, :edit, :update
  index do
    column :username
    column "Current Week ROI Balance", :current_total_weekly_roi_amount
    actions
  end

  form do |f|
    f.inputs do
      f.input :current_total_weekly_roi_amount
    end
    actions
  end

end
