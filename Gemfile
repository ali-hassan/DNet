source 'https://rubygems.org'
ruby '2.7.2'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'sassc-rails'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
group :development, :test do
  gem 'pry-byebug'
end


# gem 'therubyracer', '~> 0.12.3', platforms: :ruby
gem 'js-routes', '~> 1.3.3'

# Color utilities needed for landing page
gem 'color', '~> 1.8'

gem 'uuidtools', '~> 2.1.5'
gem 'transit-ruby', '~> 0.8.1'

# Markdown parser
gem 'redcarpet', '~> 3.4.0'

gem 'intercom'

gem 'twitter_cldr'
gem 'memoist'
gem 'biz'
gem 'omniauth-google-oauth2'
gem 'delayed_job', '~> 4.1.3'
gem 'delayed_job_active_record', '~> 4.1.2'

gem 'web_translate_it', '~> 2.4.1'
gem 'rails-i18n'
gem 'devise', '~> 4.3.0'
gem 'devise-encryptable', '~> 0.2.0'
gem "omniauth-facebook", '~> 4.0.0'

# Dynamic form adds helpers that are needed, e.g. error_messages
gem 'dynamic_form'
gem "truncate_html"
gem 'money-rails'

gem "capistrano", '=3.11.0'
gem 'capistrano3-delayed-job', '~> 1.0'
gem 'capistrano-ssh-doctor', '~> 1.0'
gem 'capistrano-rvm'
gem 'capistrano-rails',   require: false
gem 'capistrano-bundler', require: false
gem 'capistrano-passenger'
gem 'capistrano-npm'
gem 'client_side_validations'
gem 'activeadmin', '=1.4.3'
# ActiveAdmin-Select2: Drop down menus
gem 'activeadmin-select2'#, '0.1.8'
gem "blockchain"
#gem 'bitpay-sdk', require: 'bitpay_sdk', github: 'bitpay/ruby-client'
gem 'carrierwave', '~> 1.0'
gem 'sidekiq'
gem "attr_encrypted", "~> 3.1.0"
gem 'capistrano-sidekiq' , group: :development
gem 'coinpayments'
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'whenever', require: false
gem 'rails_autolink'
gem 'will_paginate'
gem "kaminari"
gem "recaptcha"
gem 'activeadmin-xls', '~>2.0.0'
