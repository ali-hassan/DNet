class WithdrawlRequest < ApplicationRecord
  belongs_to :user
  monetize :pts_cents
  after_create { |wc| wc.user.update(withdrawl_date: Time.current.in_time_zone('Hong Kong')) }
end
