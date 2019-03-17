class WithdrawlRequest < ApplicationRecord
  belongs_to :user
  monetize :pts_cents
end
