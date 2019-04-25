require 'forwardable'

class PerformWeeklyUser
  extend Forwardable

  def_delegators :@user, :current_package_iteration, :current_week_roi_amount,
    :current_week_iteration, :total_week_roi_amount, :update, :current_weekly_percentage,
    :total_weekly_percentage_amount, :decrement!, :package_price, :current_x_factor_income,
    :adapter, :current_total_weekly_roi_amount, :total_income, :reload, :is_pin?

  def initialize(user)
    @user = user
  end

  def perform
    calculate_condition && calculate || true
  end
  def calculate_condition(amount_sum=0)
    ((reload.current_package_iteration > 0) || is_pin?) && (adapter.max_package_total_earning >= (adapter.total_income.try(:to_f) + amount_sum))
  end
  def calculate
    update(params); log_weekly_roi; decrement!(:current_package_iteration); check_for_next_week
  end
  def check_for_next_week
      (@user.reload.current_package_iteration > 0) && WeeklyPlanBonusWorker.perform_in(1.week.from_now,{ user_id: @user.id })
  end
  def log_weekly_roi
    @user.log_histories.create(message: "Weekly ROI $#{current_week_roi_amount_sum} Current X factor income #{current_x_factor_income} Total Income #{ total_income_sum } ", log_type: "weekly_roi")
  end
  def params
    {
      current_week_roi_amount: current_week_roi_amount_sum,
      total_weekly_percentage_amount: total_weekly_percentage_amount_sum,
      current_total_weekly_roi_amount: cwras,
      current_x_factor_income: calculate_x_factor_sum,
      total_income: total_income_sum,
    }
  end
  def total_income_sum
    @user.total_income.try(:to_f) + current_week_roi_amount_sum
  end
  def calculate_x_factor_sum
    current_x_factor_income.try(:to_f) + current_week_roi_amount_sum
  end
  def current_week_roi_amount_sum
    package_price / 100 * current_weekly_percentage
  end
  def total_weekly_percentage_amount_sum
    current_week_roi_amount_sum + total_weekly_percentage_amount.to_f
  end
  def cwras
    current_week_roi_amount_sum + current_total_weekly_roi_amount.to_f
  end
end
