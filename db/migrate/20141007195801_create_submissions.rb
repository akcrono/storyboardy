class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :body
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end

    add_index :submissions, :user_id
    add_index :submissions, :story_id
  end
end
