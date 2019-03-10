require 'forwardable'

class PerformWeeklyUser
  extend Forwardable

  def_delegators :@user, :current_package_iteration, :current_week_roi_amount,
    :current_week_iteration, :total_week_roi_amount, :update, :current_weekly_percentage,
    :total_weekly_percentage_amount, :decrement!, :package_price, :current_x_factor_income,
    :adapter

  def initialize(user)
    @user = user
  end

  def perform
    calculate_condition && calculate || true
  end
  def calculate_condition
    (current_package_iteration > 0) && (adapter.max_package_total_earning > current_x_factor_income.try(:to_f))
  end
  def calculate
    update(params); decrement!(:current_package_iteration); check_for_next_week
  end
  def check_for_next_week
    (@user.reload.current_package_iteration > 0) && WeeklyPlanBonusWorker.perform_in(1.week.from_now,{ user_id: @user.id })
  end
  def params
    {
      current_week_roi_amount: current_week_roi_amount_sum,
      total_weekly_percentage_amount: total_weekly_percentage_amount_sum,
      current_total_weekly_roi_amount: current_weekly_roi_amount_sum,
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
  def current_weekly_roi_amount_sum
    current_week_roi_amount_sum + current_week_roi_amount.to_f
  end
end
