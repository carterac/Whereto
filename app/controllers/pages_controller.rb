require 'foursquare'

class PagesController < ApplicationController
  
  def home
    @title = "home"
    
    # oauth_key = 'HD5ZYV1DJSQE2FXEX32F54205X43WQ3W2LTEVORFD413OCAL'
    # oauth_secret = '1JGVNUDPLFNTDMLYA0I4DMW0ERPVYAFUMJAULLUJVCKHLBKP'

    oauth_key = 'client_id'
    oauth_secret = 'client_secret'

    
    @access_token = '2MBSVSBZNE5LHAA4RKQNXZI1Q30BXD1PR12ALR12KQTPLBF1'
    
    @venue = Foursquare::Venue.new(@access_token)
    
    @text = @venue.search({:ll => '40.723291,-73.991815'})
    
  end
  
end
