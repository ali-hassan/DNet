class AddToCurrentRewardToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_reward, :string
  end
end
