class UserTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  monetize :amount_cents
  validates :user, presence: true
  delegate :smart_wallet_balance, to: :user, allow_nil: true
  delegate :bonus_wallet, to: :user, allow_nil: true
  delegate :full_name, allow_nil: true, to: :receiver, prefix: true

  validate do |ut|
    ut.errors.add(:amount, "Your Balance isn't sufficent") if user.send(ut.user_wallet_transafer).to_f < ut.amount.try(:to_f)
  end
  after_create do |ut|
    (ut.wallet_type == "cash_wallet") && ut.receiver.update(cash_wallet_minus: ut.receiver.cash_wallet_minus.try(:to_f) + ut.amount.try(:to_f), smart_wallet_balance: ut.receiver.smart_wallet_balance.try(:to_f) + ut.amount.try(:to_f))
  end
  def user_wallet_transafer
    { cash_wallet: :cash_wallet_total, smart_wallet: :smart_wallet_balance }[wallet_type.try(:to_sym)]
  end
end
