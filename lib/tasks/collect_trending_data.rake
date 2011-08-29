require "#{::Rails.root}/app/helpers/pages_helper.rb"
include PagesHelper

namespace :db do
  desc "Regularly scheduled call to FS for data."
  task :collect_trending_data => :environment do
    
#  Rake::Task['db:reset'].invoke
    
  @madison_sqaure_park_ll = '40.742047,-73.987995'
  @houston_bowery_ll = '40.723291,-73.991815'
    
  trending({:ll => @madison_sqaure_park_ll})["response"]["venues"].each do |i|
		
		i['categories'].each do |j|
	
				if j['name'] == "Bar" || j['name'] == "Sports Bar" || j['name'] == "Dive Bar" || j['name'] == "Pub" || j['name'] == "Restaurant"
								
								#check to see if venue is already in the database:
								if Venue.find_by_foursquare_id(i['id']).nil?
								
									Venue.create(
										:foursquare_id => i['id'],
										:name => i['name'],
										:address => i['location']['address'],
										:city => i['location']['city'],
										:state => i['location']['state'],
										:zip => i['location']['postalCode'],
										:lat => i['location']['lat'],
										:lng => i['location']['lng']
									)
									puts "Created venue: " + i['name']
								end	
								
								cur_venue = Venue.find_by_foursquare_id(i['id'])
								
								puts "Creating #{i['hereNow']['count']} visit records for " + cur_venue.name
								
								if i['hereNow']['count'] > 0
									herenow(i['id'])['response']['hereNow']['items'].each do |k|
										
										
										if Patron.find_by_foursquare_id(k['user']['id']).nil?
											Patron.create(
												:foursquare_id => k['user']['id'],
												:f_name => k['user']['firstName'],
												:l_name => k['user']['lastName'],
												:gender => k['user']['gender'],
												:photo => k['user']['photo'],
												:home_city => k['user']['homeCity']
											)
											puts "Created user: " + k['user']['firstName'] + " from " + k['user']['homeCity']
										end
										
										cur_patron = Patron.find_by_foursquare_id(k['user']['id'])
										
										cur_visit = Visit.find_by_patron_id(cur_patron.id)
										
										if cur_visit.nil?
										  Visit.create(
											  :patron_id => cur_patron.id,
											  :venue_id => cur_venue.id,
											  :fs_created_at => k['createdAt']					
										    )
										else
										  if cur_visit.fs_created_at == k['createdAt'] || cur_visit.venue_id == cur_venue.id
										    
										  else 
  										  Visit.create(
  											  :patron_id => cur_patron.id,
  											  :venue_id => cur_venue.id,
  											  :fs_created_at => k['createdAt']					
  										    )
										  end
										end
										
									end
								end								
				end
		end
	end
  end
end