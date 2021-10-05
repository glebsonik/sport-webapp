class CreateArticleTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :article_translations do |t|
      t.references :article, foreign_key: true
      t.references :language, foreign_key: true
      t.string :picture
      t.string :alt_image
      t.string :caption
      t.string :headline
      t.text :content
      t.date :publish_date
      t.boolean :show_comments

      t.timestamps
    end
  end
end
