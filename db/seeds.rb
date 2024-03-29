# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
puts "DB seeding started"
Setting.find_or_create_by key: "tree_node", value: "left"
Setting.find_or_create_by key: "default_weekly_roi", value: 6
Setting.find_or_create_by key: "default_weekly_cycle", value: 6
Setting.find_or_create_by key: "default_weekly_starter_%", value: 4
Setting.find_or_create_by key: "default_weekly_basic_%", value: 5
Setting.find_or_create_by key: "default_weekly_advance_%", value: 6
Setting.find_or_create_by key: "default_direct_bonus_%", value: 8
Setting.find_or_create_by key: "default_indirect_bonus_%_at_lvl_1", value: 2
Setting.find_or_create_by key: "default_indirect_bonus_%_at_lvl_2", value: 1
Setting.find_or_create_by key: "default_indirect_bonus_%_at_lvl_3", value: 1
Setting.find_or_create_by key: "default_indirect_bonus_%_at_lvl_4", value: 1
Setting.find_or_create_by key: "default_indirect_bonus_%_at_lvl_5", value: 0.5
Setting.find_or_create_by key: "default_indirect_bonus_%_at_lvl_6", value: 0.5
Setting.find_or_create_by key: "default_starter_package_xfactor", value: 4
Setting.find_or_create_by key: "default_basic_package_xfactor", value: 5
Setting.find_or_create_by key: "default_advance_package_xfactor", value: 6
Setting.find_or_create_by key: "register_button_link", value: "https://google.com"
puts "********************************* AdminUser *********************************************"
begin
  admin_user = AdminUser.create!(email: 'admin@DNet.com', password: 'Password123', password_confirmation: 'Password123')
  User.create(email: "admin1@DNet.com", password: "Password123", password_confirmation: 'Password123', username: "admin", is_admin: true, first_name: "DNet", last_name: "admin",smart_wallet_balance: "300000")
rescue
end
puts "********************************* AdminUser *********************************************=   <<<<--  #{admin_user}    ->>>>"
puts "DB seeding Finished"