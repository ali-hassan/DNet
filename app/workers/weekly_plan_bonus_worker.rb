class WeeklyPlanBonusWorker
  include Sidekiq::Worker

  def perform(args)
    User.find(args[:user_id]).adapter.earn_weekly_point
  end
end
