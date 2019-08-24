class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.string :google_id
      t.string :address
      t.json :coordinate
      t.integer :access_level, default: 0
      t.integer :price
      t.boolean :claimed, default: false

      t.timestamps
    end
  end
end
