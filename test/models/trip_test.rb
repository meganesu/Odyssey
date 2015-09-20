require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:megan)
  	@trip = @user.trips.build(name: "Lorem ipsum",
                     start_loc: "New York, NY",
                     end_loc: "San Francisco, CA")
  end

  test "should be valid" do
  	assert @trip.valid?
  end

  test "user id should be present" do
  	@trip.user_id = nil
  	assert_not @trip.valid?
  end

  test "name should be present" do
    @trip.name = "  "
    assert_not @trip.valid?
  end

  test "name should be at most 60 characters" do
    @trip.name = "a" * 61
    assert_not @trip.valid?
  end

  test "start_loc should be present" do
    @trip.start_loc = "  "
    assert_not @trip.valid?
  end

  test "end_loc should be present" do
    @trip.end_loc = "  "
    assert_not @trip.valid?
  end

  test "order should be most recent first" do
    assert_equal trips(:most_recent), @user.trips.first
  end

end
