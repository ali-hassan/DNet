class DeducateWithdrawlAmount
  attr_accessor :withdrawl
  def initialize(withdrawl)
    self.withdrawl = withdrawl
  end
  def save
    withdrawl.user.update(cash_wallet_minus: withdrawl.user.cash_wallet_minus.to_f + withdrawl.pts.to_f)
  end
end
