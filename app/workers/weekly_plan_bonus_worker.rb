class WeeklyPlanBonusWorker
  include Sidekiq::Worker

  def perform(args)
    User.find_by(id: args["user_id"]).try(:adapter).try(:earn_weekly_point)
  end
end
