class CreateTrackings < ActiveRecord::Migration[7.1]
  def change
    create_table :trackings do |t|
      t.string :area
      t.string :last_seen

      t.timestamps
    end

    add_reference :trackings, :vessel, foreign_key: true, index: true
  end
end
