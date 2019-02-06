class DeletePostsubTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :postsubs
  end
end
