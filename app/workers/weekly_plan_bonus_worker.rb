class WeeklyPlanBonusWorker
  include Sidekiq::Worker

  def perform(user)
    user.earn_weekly_point
  end
end
