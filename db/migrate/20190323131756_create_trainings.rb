class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.string :heading
      t.string :video_url

      t.timestamps
    end
  end
end
