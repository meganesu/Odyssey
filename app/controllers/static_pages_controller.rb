class StaticPagesController < ApplicationController

	def home
		if logged_in?
			@feed_items = current_user.feed.paginate(page: params[:page])
			@trip = current_user.trips.build  # Use for 'Create new trip' form in modal
		end
	end

	def help
	end

	def about
	end

	def contact
	end

end
