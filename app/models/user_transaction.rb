class UserTransaction < ApplicationRecord
  has_many :log_histories, as: :logable
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  monetize :amount_cents
  validates :user, presence: true
  validates :receiver, presence: true
  delegate :smart_wallet_balance, to: :user, allow_nil: true
  delegate :bonus_wallet, to: :user, allow_nil: true
  delegate :full_name, allow_nil: true, to: :receiver, prefix: true

  validate do |ut|
    ut.errors.add(:amount, "Your Balance isn't sufficent") if user.send(ut.user_wallet_transafer).to_f < ut.amount.try(:to_f)
  end
  after_create do |ut|
    (ut.wallet_type == "cash_wallet") && ut.log_and_pay
    (ut.wallet_type == 'weekly_roi') && ut.log_and_pay_to_weekly_roi
    (ut.wallet_type == 'smart_wallet') && ut.log_and_pay_smart_wallet
  end
  def log_and_pay_smart_wallet
    user.log_histories.create(logable: self, log_type: wallet_type)
    user.update(smart_wallet_balance: user.smart_wallet_balance.to_f - amount.try(:to_f))
    receiver.update(smart_wallet_balance: receiver.smart_wallet_balance.to_f + amount.try(:to_f))
  end
  def log_and_pay_to_weekly_roi
    user.log_histories.create(logable: self, log_type: wallet_type)
    receiver.update(
      smart_wallet_balance: receiver.smart_wallet_balance.try(:to_f) + amount.try(:to_f),
      current_total_weekly_roi_amount: receiver.current_total_weekly_roi_amount.try(:to_f) - amount.try(:to_f)
    )
  end
  def log_and_pay
    user.log_histories.create(logable: self, log_type: wallet_type)
    receiver.update(cash_wallet_minus: receiver.cash_wallet_minus.try(:to_f) + amount.try(:to_f), smart_wallet_balance: receiver.smart_wallet_balance.try(:to_f) + amount.try(:to_f))
  end
  def user_wallet_transafer
    { cash_wallet: :cash_wallet_total, smart_wallet: :smart_wallet_balance, weekly_roi: :current_total_weekly_roi_amount }[wallet_type.try(:to_sym)]
  end
end
