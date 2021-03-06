class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :author, foreign_key: {to_table: :users}
      t.references :category, foreign_key: true
      t.references :conference, foreign_key: true
      t.references :team, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
