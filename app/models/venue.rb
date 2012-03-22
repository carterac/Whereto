class Venue < ActiveRecord::Base
	has_many :patrons, :through => :visits
	
	validates :foursquare_id, 		:presence => true,
									:uniqueness => { :case_sensitive => false }
	
	validates :name, 				:presence => true
	
  default_scope :order => 'name ASC'
  
  def to_param
    foursquare_id
  end
end
