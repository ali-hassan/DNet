class AddCreatedByIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :created_by_id, :integer
  end
end
