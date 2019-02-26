# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Setting.find_or_create_by key: "tree_node", value: "left"
Setting.find_or_create_by key: "default_weekly_roi", value: 6
Setting.find_or_create_by key: "default_weekly_cycle", value: 6
Setting.find_or_create_by key: "default_weekly_starter_%", value: 4
Setting.find_or_create_by key: "default_weekly_basic_%", value: 5
Setting.find_or_create_by key: "default_weekly_advance_%", value: 6

AdminUser.create!(email: 'admin@forexhometrade.com', password: 'Password123', password_confirmation: 'Password123') #if Rails.env.development?
User.create(email: "admin1@forexhometrade.com", password: "Password123", password_confirmation: 'Password123', username: "admin", is_admin: true, first_name: "forex", last_name: "admin",smart_wallet_balance: "300000")
