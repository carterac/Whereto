class CreatePatrons < ActiveRecord::Migration
  def self.up
    create_table :patrons do |t|
      t.integer :foursquare_id
      t.string :f_name
      t.string :l_name
      t.string :gender
      t.string :photo
      t.string :home_city

      t.timestamps
    end
  end

  def self.down
    drop_table :patrons
  end
end
