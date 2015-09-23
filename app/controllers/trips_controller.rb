class TripsController < ApplicationController

	before_action :logged_in_user
	before_action :correct_user, only: [:edit, :update, :destroy]

	def show
		@trip = Trip.find(params[:id])
		@locations = @trip.locations

		# Use for '+ Location' form in modal
		@location = Location.new
	end

	def new
		@trip = Trip.new
	end

	def create
		# Build automatically associates @trip with current_user
		@trip = current_user.trips.build(trip_params)
		if @trip.save
			flash[:success] = "Trip \'#{@trip.name}\' created!"
			redirect_to user_path(current_user)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @trip.update_attributes(trip_params)
			# Handle a successful update.
			flash[:success] = "Trip \'#{@trip.name}\' updated"
			redirect_to current_user
		else
			render 'edit'
		end
	end

	def destroy
		@trip.destroy
		flash[:success] = "Trip \'#{@trip.name}\' deleted"
		redirect_to request.referrer || root_url
	end


	private

		# Use strong parameters
		def trip_params
			params.require(:trip).permit(:name, :description, :start_loc, :end_loc)
		end

		def correct_user
			@trip = current_user.trips.find_by(id: params[:id])
			redirect_to root_url if @trip.nil?
		end

end
