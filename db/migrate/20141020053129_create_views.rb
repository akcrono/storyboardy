class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :user_id
      t.integer :submission_id

      t.timestamps
    end

    add_index :views, [:submission_id, :user_id], unique: true
    add_index :views, :user_id
    add_index :views, :submission_id
  end
end
