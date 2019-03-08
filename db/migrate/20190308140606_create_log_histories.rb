class CreateLogHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :log_histories do |t|
      t.references :user, foreign_key: true
      t.text :message
      t.references :logable, polymorphic: true
      t.string :log_type

      t.timestamps
    end
  end
end
