class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :schemer_id
      t.integer :scheme_id
      t.boolean :is_done

      t.timestamps
    end
    add_index :connections, :schemer_id
    add_index :connections, :scheme_id
    add_index :connections, [:schemer_id, :scheme_id], unique: true    
  end
end
