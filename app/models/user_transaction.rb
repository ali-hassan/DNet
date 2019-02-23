class UserTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  monetize :amount_cents
  validates :amount, numericality: { greater_than: 50 }
  validates :user, presence: true
  delegate :smart_wallet_balance, to: :user, allow_nil: true
  delegate :full_name, allow_nil: true, to: :receiver, prefix: true
end
