require 'rubygems'
  require 'foursquare'

  oauth_key 'HD5ZYV1DJSQE2FXEX32F54205X43WQ3W2LTEVORFD413OCAL'
  oauth_secret = '1JGVNUDPLFNTDMLYA0I4DMW0ERPVYAFUMJAULLUJVCKHLBKP'

  oauth = Foursquare::OAuth.new(oauth_key, oauth_secret)

  request_token = oauth.request_token.token
  request_secret = oauth.request_token.secret

  # redirecting user to foursquare to authorize
  oauth.request_token.authorize_url

  # foursquare redirects back to your callback url, passing the verifier in the url params

  access_token, access_secret = oauth.authorize_from_request(request_token, request_secret, verifier)

  # save the user's access token and secret


  oauth = Foursquare::OAuth.new(oauth_key, oauth_secret)
  oauth.authorize_from_access(access_token, access_secret)
  foursquare = Foursquare::Base.new(oauth)

  foursquare.test

  foursquare.venues :geolat => geolat, :geolong => geolong, :limit => 10, :q => 'pizza'
  foursquare.tips :geolat => geolat, :geolong => geolong, :limit => 10
  foursquare.checkins :geolat => geolat, :geolong => geolong

  checkin = {
    :vid => vid,
    :shout => "this is what i'm up to",
    :venue => "Cohabitat",
    :private => 0,
    :twitter => 0,
    :geolat => geolat,
    :geolong => geolong
  }

  # these all do the same thing
  # the response is a hashie object built from the checkin json.  so you can do new_checkin.shout
  new_checkin = foursquare.checkin(checkin)
  new_checkin.class
  => Hashie::Mash
  new_checkin
  => {...checkin hashie...}
  new_checkin = foursquare.send('checkin=', checkin)
  new_checkin.class
  => Hash
  new_checkin
  => {'checkin' => {...}}
  new_checkin = foursquare.api(:checkin=, checkin)
  new_checkin.class
  => Hashie::Mash
  new_checkin
  => {:checkin => {...}}

  foursquare.history :limit => 10
  foursquare.api(:history, :limit => 10).checkins
  foursquare.user :uid => user_id :badges => 0
  foursquare.user # currently authenticated user
  foursquare.friends :uid => 99999
  foursquare.venue :vid => venue_id
  foursquare.addvenue :name => name, :address => address, :city => city, ...
  foursquare.venue_proposeedit :venue_id => venue_id, :name => name, :address => address, :city => ...
  foursquare.venue_flagclosed :vid => venue_id
  foursquare.addtip :vid => 12345, :tip => 'here is a tip'
  foursquare.tip_marktodo :tid => tip_id
  foursquare.tip_markdone :tid => tip_id
  foursquare.friend_requests
  foursquare.friend_approve :uid => friend_id
  foursquare.friend_deny :uid => friend_id
  foursquare.friend_sendrequest :uid => friend_id
  foursquare.findfriends_byname :q => search_string
  foursquare.findfriends_byphone :q => '555 123'
  foursquare.findfriends_bytwitter :q => twitter_name
  foursquare.settings_setping :uid => user_id, :self => global_ping_status