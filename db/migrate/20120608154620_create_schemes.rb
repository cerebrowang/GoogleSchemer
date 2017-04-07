class CreateSchemes < ActiveRecord::Migration
  def change
    create_table :schemes do |t|
      t.string :content
      t.integer :user_id
      t.string :image
      t.string :where_type, :default => "option_anywhere"

      t.timestamps
    end
    add_index :schemes, [:user_id, :created_at]
  end
end