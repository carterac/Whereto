require "#{::Rails.root}/app/helpers/pages_helper.rb"
include PagesHelper

namespace :db do
  desc "Regularly scheduled call to FS for data."
  task :collect_trending_data => :environment do

    @madison_square_park_ll = '40.742047,-73.987995'
    @houston_bowery_ll = '40.723291,-73.991815'
    
    api_calls = 0
    
    

    nyc_hoods = {
      "east_village" => '40.726641,-73.981794',
      "LES" => '40.715802,-73.989133',
      "little_italy" => '40.719624,-73.997684',
      "soho" => '40.723124,-74.004644',
      "west_village" => '40.734897,-74.005285',
      "greenwich_village" => '40.731373,-73.996085',
      "chelsea" => '40.746509,-73.999261',
      "union_square_flatiron_gramercy" => '40.740541,-73.988905',
      "times_square_use2kradius" => '40.759895,-73.983457',
      "williamsburg_use2kradius" => '40.710622,-73.950595',
      "prospect_heights_use2kradius" => '40.683075,-73.970599',
      "the_claremount" => '40.731244,-73.986669'
    }
    
    nyc_hoods.each do |key, value| 
          
      if key == "prospect_heights_use2kradius" || key == "williamsburg_use2kradius" || key == "times_square_use2kradius"
        radius = 2000
      else
        radius = 1000
      end

      # e.g. "east_village (radius = 1000):"
      puts key + ' (radius = ' + radius.to_s + '):'
      
      api_calls += 1
      trending({:ll => value, :radius => radius})["response"]["venues"].each do |i|

    		categories = ["Bar","Sports Bar","Dive Bar","Pub","Restaurant","Nightclub"]

  			good_category = 0
  			i['categories'].each do |j|
	  		  if categories.include?(j['name'])
      		  good_category = 1
    			end  
  			end
            
        if good_category == 1
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
  						puts "\tCreated venue: " + i['name']
  					end	

  					cur_venue = Venue.find_by_foursquare_id(i['id'])

  					if i['hereNow']['count'] > 0
  					  puts "\t#{i['hereNow']['count']} at " + cur_venue.name
  					  
  					  api_calls += 1
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
          			puts "\tCreated user: " + k['user']['firstName'] + " from " + k['user']['homeCity']
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
    
    	puts "\tTotal API calls = " + api_calls.to_s
    
    end
  end
end