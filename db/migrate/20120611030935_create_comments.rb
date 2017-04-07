class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.references :scheme

      t.timestamps
    end
    add_index :comments, :scheme_id
  end
end
