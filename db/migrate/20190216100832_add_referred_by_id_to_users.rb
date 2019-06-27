class AddReferredByIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referred_by_id, :integer
  end
end
