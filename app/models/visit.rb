class Visit < ActiveRecord::Base
	belongs_to :venue
	belongs_to :patron
end
