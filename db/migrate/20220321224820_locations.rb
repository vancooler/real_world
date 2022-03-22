class Locations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :road_number
      t.string :road_name
      t.float :lat 
      t.float :lon

      t.timestamps
    end
  end
end
