class VenuesController < ApplicationController
  def index
  end

  def show
    @venue = Venue.find(params[:id])
    @title = @venue.name
  end
end
