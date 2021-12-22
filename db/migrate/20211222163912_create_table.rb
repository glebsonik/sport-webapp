class CreateTable < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletter_subscriptions do |t|
      t.string :email
      t.string :type
      t.string :name
    end
    add_index :newsletter_subscriptions, :email, unique: true
  end
end
