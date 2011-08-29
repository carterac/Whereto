class ChangeDataTypeForFsid < ActiveRecord::Migration
  def self.up
	change_table :venues do |t|
		t.change :foursquare_id, :string
	end
  end

  def self.down
	change_table :venues do |t|
		t.change :foursquare_id, :integer
	end
  end
end
