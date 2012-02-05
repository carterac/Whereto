require "#{::Rails.root}/app/helpers/pages_helper.rb"
include PagesHelper

namespace :db do
  desc "Regularly scheduled call to FS for data."
  task :set_trend_count_times => :environment do
    venues = Venue.all
    time_now = DateTime.now
    venues.each do |v|
      v.update_attributes(
        :daily_trend_time => time_now,
        :weekly_trend_time => time_now,
        :monthly_trend_time => time_now,
        :yearly_trend_time => time_now,  
        :daily_trend_count => 0,
        :weekly_trend_count => 0,
        :monthly_trend_count => 0,
        :yearly_trend_count => 0
      )
      puts "Set the trending count times for #{v.name}."
    end
  end
end