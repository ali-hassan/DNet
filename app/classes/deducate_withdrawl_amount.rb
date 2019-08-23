class DeducateWithdrawlAmount
  attr_accessor :withdrawl
  def initialize(withdrawl)
    self.withdrawl = withdrawl
  end
  def save
    withdrawl.wallet == "Cash Wallet" && withdrawl.user.update(cash_wallet_minus: withdrawl.user.cash_wallet_minus.to_f + withdrawl.pts.to_f)
    withdrawl.wallet == "ROI Wallet" && withdrawl.user.update(total_weekly_percentage_amount: withdrawl.user.total_weekly_percentage_amount.to_f - withdrawl.pts.to_f)
  end
end
