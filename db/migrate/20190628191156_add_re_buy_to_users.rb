class AddReBuyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :re_buy, :boolean, default: false
  end
end
