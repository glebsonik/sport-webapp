class CreateConferenceTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :conference_translations do |t|
      t.references :conference, foreign_key: true
      t.references :language, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
