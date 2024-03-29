class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.string :followed_id
      t.string :integer

      t.timestamps
    end

    add_index :relationships, :followed_id
    add_index :relationships, :follower_id
    add_index :relationships, [:followed_id, :follower_id], unique: true #unique pairs so cannot follow twice

  end
end
