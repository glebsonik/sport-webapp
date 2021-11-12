class CreateCategoryTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :category_translations do |t|
      t.references :category, foreign_key: true
      t.references :language, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
