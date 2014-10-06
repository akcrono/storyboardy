class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :first_entry, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
