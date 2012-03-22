class VenuesController < ApplicationController
  def index
  end

  def show
    @venue = Venue.find_by_foursquare_id(params[:id])
    if @venue.nil?
      @title = "Venue Not Found"
    else
      @title = @venue.name
    end
  end
end
