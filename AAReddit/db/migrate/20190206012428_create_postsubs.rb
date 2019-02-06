class CreatePostsubs < ActiveRecord::Migration[5.2]
  def change
    create_table :postsubs do |t|
      t.integer :sub_id, null:false
      t.integer :post_id, null:false
      t.timestamps
    end
    add_index :postsubs, [:sub_id, :post_id], unique: true
    add_index :postsubs, :sub_id
    add_index :postsubs, :post_id
  end
end
