namespace :forex_home_trade do
  desc "Deduct monthly fees"
  task monthly_fees_scheduler: :environment do
    User.where("package_id is not null").each do |user|
      if user.adapter.current_package.present?
        puts("Charging for user id #{user.id} and username #{user.username}")
        admin_fees = user.adapter.current_package["price"] / 100 * 2
        User.add_amount(admin_fees)
        user.log_histories.build(log_type: 'cash_wallet', message: "Charged Admin fees $#{admin_fees}")
        user.update(cash_wallet_minus: user.cash_wallet_minus.to_f + admin_fees)
      end
    end
  end
  desc 'Monthly maintance charges'
  task monthly_maintance_fees_scheduler: :environment do
    User.where('(package_id is not null) or is_pin = ?', true).each do |user|
      puts("Charging maintance fees for user id #{user.id} and username #{user.username}")
      maintance_fees = user.adapter.pin_or_package_amount / 100 * 2
      User.add_amount(maintance_fees)
      user.log_histories.build(log_type: 'system_transaction', message: "Charged maintenance fees of $#{maintance_fees}")
      user.update(cash_wallet_minus: user.cash_wallet_minus.to_f + maintance_fees)
    end
  end
end
