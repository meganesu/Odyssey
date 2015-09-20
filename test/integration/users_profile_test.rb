require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper
	include ERB::Util

	def setup
		@user = users(:megan)
	end

	test "profile display" do
		get user_path(@user)
		assert_template 'users/show'
		assert_select 'title', full_title(@user.first_name + " " + @user.last_name)
		assert_select 'h1', text: @user.first_name + " " + @user.last_name
		assert_select 'h1>img.gravatar'
		assert_match @user.trips.count.to_s, response.body
		assert_select 'div.pagination'
		@user.trips.paginate(page: 1).each do |trip|
			assert_match html_escape_once(trip.name), response.body
			# Use html_escape to escape single quotes in location names (ex. O'Reillyburgh)
			assert_match html_escape_once(trip.start_loc) + " -> " +
									 html_escape_once(trip.end_loc), response.body
		end
	end

end