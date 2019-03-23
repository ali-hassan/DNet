class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
