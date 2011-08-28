module PagesHelper
      def get_here_now(id)
        
        @access_token = '2MBSVSBZNE5LHAA4RKQNXZI1Q30BXD1PR12ALR12KQTPLBF1'
        cur_here_now = Foursquare::Venue.new(@access_token)

        return cur_here_now.herenow(id)
        
      end
end
