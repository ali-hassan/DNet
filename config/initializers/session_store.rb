Rails.application.config.session_store :cookie_store, key: '_forex_home_trade_session', domain: {
  production:  '.forexhometrade.com',
  development: '.lvh.me'
}.fetch(Rails.env.to_sym, :all)
