class LocationsController < ApplicationController

	def new
		@location = Location.new
	end

	def create
		@trip = Trip.find(params[:trip_id])
		@location = @trip.locations.build(loc_params)
		if @location.save
			flash[:success] = "\'#{@location.name}\' was added to \'#{@trip.name}\'!"
			redirect_to trip_path(@trip)
		else
			# Handle errors in location (ex. location not found, or form field blank)
			render 'new' # TEMPORARY FIX (should redisplay modal w/ error messages)
		end
	end

	private

		# Use strong parameters
		def loc_params
			params.require(:location).permit(:name, :arrival, :departure)
		end

end
