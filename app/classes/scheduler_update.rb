class SchedulerUpdate < SimpleDelegator

  def active_job
    [ Sidekiq::ScheduledSet.new.select { |ss| ss.item["args"][0]["user_id"] == id } ].flatten
  end
  def destroy_old_jobs_and_update_schedule(time_now=15.minutes.from_now)
    active_job.each(&:delete); WeeklyPlanBonusWorker.perform_in(time_now, {user_id: id})
  end
  def active_job?
    active_job.present?
  end
  alias_method :doj_update, :destroy_old_jobs_and_update_schedule
end
