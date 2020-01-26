class CreateGeofences < ActiveRecord::Migration[6.0]
  def change
    create_table :geofences do |t|
      t.float :coordinates, :array => true
      t.string :area_name
      t.timestamps
    end
  end
end
