require "#{::Rails.root}/app/helpers/pages_helper.rb"
include PagesHelper
require 'csv'

namespace :db do
  desc "Regularly scheduled call to FS for data."
  task :create_venue_scores => :environment do
    @venues = Venue.all
    @venues.each do |v|
      puts "Analyzing the venue: #{v.name}"
      get_venue(v.foursquare_id)['response']['venue']['tags'].each do |t|
      #Options: id, name, location, categories, hereNow (count, groups([0]friends, [1]type"others", items[each item is a checkin with User])), tags, photos, 
        CSV.foreach("#{::Rails.root}/lib/tasks/venue_tags.csv") do |row|
          if(t==row[0])
            puts "  Tag: #{t} = #{row[0]}"
            puts "  Tag Scores:"
            puts "    Fratty: #{row[2]}"
            puts "    Sporty: #{row[3]}"
            puts "    Hispter: #{row[4]}"
            puts "    Divey: #{row[5]}"
            puts "    Exclusive: #{row[6]}"
            puts "    Dance: #{row[7]}"
            
            if(v.frat_score.nil?)
              frat_score = row[2].to_i
              sport_score = row[3].to_i
              hipster_score = row[4].to_i
              dive_score = row[5].to_i
              exclusive_score = row[6].to_i
              dance_score = row[7].to_i
            else
              frat_score = v.frat_score + row[2].to_i
              sport_score = v.sport_score + row[3].to_i
              hipster_score = v.hipster_score + row[4].to_i
              dive_score = v.dive_score + row[5].to_i
              exclusive_score = v.exclusive_score + row[6].to_i
              dance_score = v.dance_score + row[7].to_i
            end
            
            v.update_attributes(
              :frat_score => frat_score,
              :sport_score => sport_score,
              :hipster_score => hipster_score,
              :dive_score => dive_score,
              :exclusive_score => exclusive_score,
              :dance_score => dance_score
            )
            
          else
            #Do Nothing
          end
  	    end
	    end
    end
  end
end