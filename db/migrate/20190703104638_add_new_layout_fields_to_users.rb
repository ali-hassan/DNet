class AddNewLayoutFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_sponsor, :boolean
  end
end
