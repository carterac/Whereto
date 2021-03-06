class Patron < ActiveRecord::Base
	has_many :venues, :through => :visits
	
	validates :foursquare_id, 		:presence => true,
									:uniqueness => { :case_sensitive => false }
									
	def to_param
    foursquare_id
  end
									
end
