class CreateAdditions < ActiveRecord::Migration
  def change
    create_table :additions do |t|
      t.integer :user_id, null: false
      t.integer :story_id, null: false
      t.text :body, null: false
      t.integer :score, null: false

      t.timestamps
    end

    add_index :additions, :user_id
    add_index :additions, :story_id
  end
end
