class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :some_id
      t.text :name
      t.text :description
      t.text :unregistered

      t.timestamps
    end

    add_index :things, :some_id, :unique => true
    add_index :things, [ :name, :description ], :unique => true
    add_index :things, :unregistered, :unique => true
  end
end
