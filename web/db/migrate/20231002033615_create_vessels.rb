class CreateVessels < ActiveRecord::Migration[7.1]
  def change
    create_table :vessels do |t|
      t.string :name
      t.string :imo
      t.string :callsign
      t.string :mmsi
      t.float  :length_meters
      t.float  :width_meters

      t.timestamps
    end

    add_reference :vessels, :vessel_type, foreign_key: true, index: true
  end
end
