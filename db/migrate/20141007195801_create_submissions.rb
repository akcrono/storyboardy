class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :body
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end
  end
end
