class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.integer :some_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
