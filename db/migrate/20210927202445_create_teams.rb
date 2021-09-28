class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.references :conference, foreign_key: true
      t.references :location, foreign_key: true
      t.string :name
      t.string :logo

      t.timestamps
    end
  end
end
