class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.integer :foursquare_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
