class CreateConferences < ActiveRecord::Migration[5.2]
  def change
    create_table :conferences do |t|
      t.references :category, foreign_key: true
      t.string :key_name

      t.timestamps
    end
  end
end
