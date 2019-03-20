class WeeklyPlanBonusWorker
  include Sidekiq::Worker

  def perform(args)
    ActiveRecord::Base.uncached do
      @user = User.find_by(id: args["user_id"])
      puts "*********************UserID which is going to take ROI: #{args["user_id"]}************"
      puts "********************User Name: #{@user.try(:username)} ****************************"
      @user.try(:adapter).try(:earn_weekly_point)
    end
  end
end
