require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:megan)
  	@other_user = users(:batman)
  	@trip = trips(:castro_valley)
    @other_trip = trips(:gotham)
  end

  test "should get new" do
    log_in_as(@user)
  	get :new
  	assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @trip
    assert_response :success, @response.body
  end

  test "should redirect create when not logged in" do
  	assert_no_difference 'Trip.count' do
  		post :create, trip: { name: "New Trip",
                            description: "This is a new trip",
                            start_loc: "New York",
                            end_loc: "Alabama" }
  	end
  	assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do # Redirect to login_url
    get :new
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @trip
    assert_not flash.empty?
    assert_redirected_to login_url
	end

	test "should redirect show when not logged in" do
    get :show, id: @trip
    assert_not flash.empty?
    assert_redirected_to login_url
	end

	test "should redirect update when not logged in" do
    patch :update, id: @trip, trip: { name: @trip.name,
                                      description: @trip.description,
                                      start_loc: @trip.start_loc,
                                      end_loc: @trip.end_loc }
    assert_not flash.empty?
    assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Trip.count' do
			delete :destroy, id: @trip
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
