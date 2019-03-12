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
      cw: [["cash_wallet"], "WITHDRAWAL HISTORY", "csw_table"],
      sw: [['smart_wallet'], 'ACCOUNT TO ACCOUNT', "csw_table"],
      db: [['direct_bonus'], 'Direct Bonus', 'db_table'],
      ib: [['indirect_bonus'], 'Indirect Bonus', 'db_table'],
      bb: [['binary_bonus'], 'Binary Bonus', 'db_table'],
      wr: [['weekly_roi'], 'Weekly ROI', 'wr_table'],
    }.with_indifferent_access[log_id]
  end
end
