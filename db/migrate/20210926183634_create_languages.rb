class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :key
      t.string :display_name
      t.string :icon
      t.boolean :hidden

      t.timestamps
    end
  end
end
