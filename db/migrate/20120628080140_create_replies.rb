class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.text :content
      t.references :comment

      t.timestamps
    end
    add_index :replies, :comment_id
  end
end
