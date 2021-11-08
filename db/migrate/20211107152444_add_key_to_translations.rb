class AddKeyToTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :category_translations, :key, :string
    add_column :conference_translations, :key, :string
    add_column :location_translations, :key, :string
  end
end
