require 'net/https'

module PagesHelper
	
	
	
	def perform_graph_request(endpoint, params = {}, method = "get")
		@access_token = '2MBSVSBZNE5LHAA4RKQNXZI1Q30BXD1PR12ALR12KQTPLBF1'
		@base_url = "https://api.foursquare.com/v2/"

		@query_string = "?"
		@query_string += "oauth_token=#{CGI.escape(@access_token)}"
	
		if method=="get"
			params.each{|key, val| @query_string += "&#{key}=#{val}"}
			url = URI.parse("#{@base_url}#{endpoint}#{@query_string}")
			request = Net::HTTP::Get.new("#{url.path}?#{url.query}",{"Content-Type"=>"text/json"})
		else
			url = URI.parse("#{@base_url}#{endpoint}#{@query_string}")
			request = Net::HTTP::Post.new("#{url.path}?#{url.query}",{"Content-Type"=>"text/json"})
			request.set_form_data(params)
		end
		
		
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		response = JSON.parse(http.start {|http| http.request(request) }.body)
		response
    end
	
	def herenow(venue_id)
      perform_graph_request("venues/#{venue_id}/herenow", {})
    end
	
	def search(params={})
      params = {:ll => "37.792694,-122.409325",
                :llAcc => "100",
                :alt => "0",
                :altAcc=>"100",
                :query=>"",
                :limit=>"50",
                :intent=>"checkin"}.merge!(params)

      perform_graph_request("venues/search", params)
    end
	
	def trending(params={})
		params = {:ll => "40.723291,-73.991815",
				:radius => "1000",
                :limit=>"50"}.merge!(params)

		perform_graph_request("venues/trending", params)
    end
	
end
