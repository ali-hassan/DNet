ActiveAdmin.register User, as: 'Report' do

  index do
    id_column
    column :full_name
    column :email
    column :is_pin
    column :pin_capacity
    column :package_id
    column :package_activation_date
    column "Total Income" do |usr|
      usr.adapter.total_income
    end
    column "Binary Bonus" do |usr|
      usr.adapter.calculate_total_binary.try(:to_f)
    end
    column "Xfactor Amount" do |usr|
      usr.adapter.total_income_calculate
    end
    column "Direct Bonus" do |usr|
      usr.direct_bonus_users_count
    end
    column "Indirect Bonus" do |usr|
      usr.indirect_bonus_users_count
    end
    column "Current ROI Balance" do |user|
      user.current_total_weekly_roi_amount.try(:to_f)
    end
    column "Total ROI Balance" do |user|
      user.total_weekly_percentage_amount.try(:to_f)
    end
    column "Cash Wallet" do |usr|
      usr.cash_wallet_total
    end
    column "Smart Wallet" do |usr|
      usr.smart_wallet_balance.try(:to_f)
    end
    column :created_at
  end
  csv do
    column :id
    column :full_name
    column :email
    column :is_pin
    column :package_id
    column :package_activation_date
    column "Total Income" do |usr|
      usr.adapter.total_income
    end
    column "Binary Bonus" do |usr|
      usr.binary_bonus.try(:to_f)
    end
    column "Xfactor Amount" do |usr|
      usr.adapter.total_income_calculate
    end
    column "Direct Bonus" do |usr|
      usr.direct_bonus_users_count
    end
    column "Indirect Bonus" do |usr|
      usr.indirect_bonus_users_count
    end
    column "Current ROI Balance" do |user|
      user.current_total_weekly_roi_amount.try(:to_f)
    end
    column "Total ROI Balance" do |user|
      user.total_weekly_percentage_amount.try(:to_f)
    end
    column "Cash Wallet" do |usr|
      usr.cash_wallet_total
    end
    column "Smart Wallet" do |usr|
      usr.smart_wallet_balance.try(:to_f)
    end
    column :created_at
  end
end
