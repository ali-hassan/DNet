require 'forwardable'

class PerformWeeklyUser
  extend Forwardable

  def_delegators :@user, :current_package_iteration, :current_week_roi_amount,
    :current_week_iteration, :total_week_roi_amount, :update, :current_weekly_percentage,
    :total_weekly_percentage_amount, :decrement!, :package_price, :t

  def initialize(user)
    @user = user
  end

  def perform
    (current_package_iteration > 0) && calculate || true
  end
  def calculate
    update(params); decrement!(:current_package_iteration); check_for_next_week
  end
  def check_for_next_week
    (@user.reload.current_package_iteration > 0) && WeeklyPlanBonusWorker.perform_at(1.week.from_now, @user)
  end
  def params
    {
      current_week_roi_amount: current_week_roi_amount_sum,
      total_weekly_percentage_amount: total_weekly_percentage_amount_sum,
      current_total_weekly_roi_amount: current_weekly_roi_amount_sum,
    }
  end
  def current_week_roi_amount_sum
    package_price / (current_weekly_percentage * 100)
  end
  def total_weekly_percentage_amount_sum
    current_week_roi_amount_sum + total_weekly_percentage_amount.to_f
  end
  def current_weekly_roi_amount_sum
    current_week_roi_amount_sum + current_total_weekly_roi_amount.to_f
  end
end
