class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :voteable_id
      t.integer :value
      t.string :voteable_type

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :voteable_id
    add_index :votes, [:voteable_id, :user_id, :voteable_type], unique: true
  end
end
