class CreateAdditions < ActiveRecord::Migration
  def change
    create_table :additions do |t|
      t.integer :user_id, null: false
      t.integer :story_id, null: false
      t.text :body, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
