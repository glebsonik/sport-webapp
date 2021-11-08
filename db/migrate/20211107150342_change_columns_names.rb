class ChangeColumnsNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :key_name, :key
    rename_column :conferences, :key_name, :key
    rename_column :locations, :key_name, :key
  end
end
