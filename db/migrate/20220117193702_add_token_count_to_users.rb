class AddTokenCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token_count, :string, default: "0"
  end
end
