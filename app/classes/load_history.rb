class LoadHistory
  attr_accessor :user, :log_id
  def initialize(user, log_id)
    self.user, self.log_id = user, log_id
  end
  def all
    user.log_histories.where(log_type: load_condition[0])
  end
  def load_condition
    {
      cw: [["cash_wallet"], "WITHDRAWAL HISTORY"],
      sw: [['smart_wallet'], 'ACCOUNT TO ACCOUNT'],
    }.with_indifferent_access[log_id]
  end
end
