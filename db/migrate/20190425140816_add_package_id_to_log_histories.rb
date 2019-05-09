class AddPackageIdToLogHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :log_histories, :package_id, :string
  end
end
