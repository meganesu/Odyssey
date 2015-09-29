class LocationsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

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

	def edit
		@location = Location.find(params[:id])
	end

	def update
		@location = Location.find(params[:id])
		if @location.update_attributes(loc_params)
			# Handle a successful update.
			flash[:success] = "Location \'#{@location.name}\' updated"
			redirect_to trip_path(@location.trip)
		else
			render 'edit'
		end
	end

	def destroy
		@location = Location.find(params[:id])
		@trip = @location.trip
		@location.destroy
		flash[:success] = "\'#{@location.name}\' has been removed from your trip"
		redirect_to trip_path(@trip)
	end

	private

		# Use strong parameters
		def loc_params
			params.require(:location).permit(:name, :arrival, :departure)
		end

end
