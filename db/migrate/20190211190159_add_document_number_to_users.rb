class AddDocumentNumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :document_number, :string
  end
end
