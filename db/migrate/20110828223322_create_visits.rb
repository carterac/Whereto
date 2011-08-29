class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :patron_id
      t.integer :venue_id
      t.integer :fs_created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
