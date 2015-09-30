require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:megan)
  	@other_user = users(:batman)
  	@trip = trips(:ridgely)
  	@location = locations(:new_york)
  end

  test "should redirect create when not logged in" do
  	assert_no_difference 'Location.count' do
  		post :create, location: { name: "Oklahoma City",
  															arrival: DateTime.now,
  															departure: DateTime.now }, trip_id: @trip
  	end
  	assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
  	get :edit, id: @location
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
  	patch :update, id: @location, location: { name: @location.name,
  																						arrival: @location.arrival,
  																						departure: @location.departure }
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
  	assert_no_difference 'Location.count' do
  		delete :destroy, id: @location
  	end
  	assert_redirected_to login_url
  end


  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @trip
    assert flash.empty?
    assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @trip, trip: { name: @trip.name,
                                      description: @trip.description,
                                      start_loc: @trip.start_loc,
                                      end_loc: @trip.end_loc }
    assert flash.empty?
    assert_redirected_to root_url
	end

	test "should redirect destroy when logged in as wrong user" do
    log_in_as(@user)
    assert_no_difference 'Trip.count' do
      delete :destroy, id: @other_trip
    end
    assert_redirected_to root_url
	end

end