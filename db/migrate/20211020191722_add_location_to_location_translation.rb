class AddLocationToLocationTranslation < ActiveRecord::Migration[5.2]
  def change
    add_reference :location_translations, :location, foreign_key: true
  end
end
