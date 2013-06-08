class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :some_id
      t.text :name
      t.text :description

      t.timestamps
    end

    add_index :things, :some_id, :unique => true
    add_index :things, [ :name, :description ], :unique => true
  end
end
