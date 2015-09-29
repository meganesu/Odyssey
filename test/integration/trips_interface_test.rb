require 'test_helper'

class TripsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:megan)
  end

  test "trip interface" do
  	log_in_as(@user)
  	get root_path
  	assert_select 'div.pagination'
  	#assert_select 'a[href=?]', new_trip_path //update when the modal tests are added
  	get new_trip_path
  	# Invalid submission
  	assert_no_difference 'Trip.count' do
  		post trips_path, trip: { name: "",
  														 start_loc: "",
  														 end_loc: "" }
  	end
  	assert_select 'div#error_explanation'
  	# Valid submission
  	assert_difference 'Trip.count', 1 do
  		post trips_path, trip: { name: "My Trip",
  														 start_loc: "New York, NY",
  														 end_loc: "New York, NY" }
  	end
  	assert_redirected_to user_path(@user)
  	follow_redirect!
  	assert_match "My Trip", response.body # trip is posted on user profile
  	get root_url
  	assert_match "My Trip", response.body # trip is posted in news feed
  	# Delete a trip
  	assert_select 'a', text: 'delete'
  	first_trip = @user.trips.paginate(page: 1).first
  	assert_difference 'Trip.count', -1 do
  		delete trip_path(first_trip)
  	end
  	# Visit a different user
  	get user_path(users(:batman))
  	assert_select 'a', text: 'delete', count: 0
  	assert_select 'a', text: 'edit', count: 0
  end

end
