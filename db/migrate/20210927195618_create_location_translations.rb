class CreateLocationTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :location_translations do |t|
      t.references :conference, foreign_key: true
      t.references :language, foreign_key: true
      t.string :country_name
      t.string :state_name
      t.string :city_name

      t.timestamps
    end
  end
end
