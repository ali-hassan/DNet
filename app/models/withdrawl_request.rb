class WithdrawlRequest < ApplicationRecord
  has_many :log_histories, as: :logable, dependent: :destroy
  belongs_to :user
  attr_accessor :amount
  monetize :pts_cents
  after_create do |wc|
    wc.user.update(withdrawl_date: Time.current.in_time_zone('Hong Kong'))
    wc.user.log_histories.create(
      logable: wc,
      log_type: :withdrawl_request,
      message: "Withdrawl pts #{wc.pts.to_f}"
    )
  end
end
