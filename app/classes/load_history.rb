class LoadHistory
  attr_accessor :user, :log_id, :page
  def initialize(user, log_id, page)
    self.user, self.log_id, self.page = user, log_id, page
  end
  def all
    user.log_histories.where(log_type: load_condition[0]).paginate(page: page, per_page: 5).order(created_at: :desc)
  end
  def load_condition
    {
      cw: [["withdrawl_request"], "WITHDRAWAL HISTORY", "wr_desc_table"],
      sw: [['smart_wallet', 'cash_wallet'], 'ACCOUNT TO ACCOUNT', "csw_table"],
      st: [['system_transaction'], 'Monthly Maintenance', "st_table"],
      db: [['direct_bonus'], 'Direct Bonus', 'db_table'],
      ib: [['indirect_bonus'], 'Indirect Bonus', 'db_table'],
      bb: [['binary_bonus'], 'Binary Bonus', 'db_table'],
      wr: [['weekly_roi'], 'Weekly ROI', 'wr_table'],
      ur: [["user_reward"], "Reward History", "wr_table"],
    }.with_indifferent_access[log_id]
  end
end
