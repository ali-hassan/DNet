class LogHistory < ApplicationRecord
  belongs_to :user
  belongs_to :logable, polymorphic: true, optional: true
end
