class WithdrawlRequest < ApplicationRecord
  belongs_to :user
  monetize :pts_cents
  after_create do |wc|
    wc.user.update(withdrawl_date: Time.current.in_time_zone('Hong Kong'))
    wc.user.log_histories.create(
      logable: wc.user,
      log_type: :withdrawl_request,
      message: "Withdrawl pts #{wc.pts.to_f}"
    )
  end
end
