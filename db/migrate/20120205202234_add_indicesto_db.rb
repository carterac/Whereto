class AddIndicestoDb < ActiveRecord::Migration
  def self.up
    add_index :patrons, :foursquare_id
    add_index :venues, :foursquare_id
    add_index :visits, :patron_id
    add_index :visits, :venue_id    
  end

  def self.down
    remove_index :patrons, :foursquare_id
    remove_index :venues, :foursquare_id
    remove_index :visits, :patron_id
    remove_index :visits, :venue_id
  end
end
