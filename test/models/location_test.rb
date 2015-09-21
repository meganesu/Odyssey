require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@trip = trips(:ridgely)
  	@loc = @trip.locations.build(name: "Dallas, TX",
  									 arrival: DateTime.civil_from_format(:local,
  									 						2015, 9, 12, 14, 0, 0),
  									 departure: DateTime.civil_from_format(:local,
  									 						2015, 9, 19, 14, 0, 0) )
  end

  test "should be valid" do
  	assert @loc.valid?
  end

  test "trip id should be present" do
  	@loc.trip_id = nil
  	assert_not @loc.valid?
  end

  test "name should be present" do
  	@loc.name = "  "
  	assert_not @loc.valid?
  end

  test "name should be at most 60 characters" do
  	@loc.name = "a" * 61
  	assert_not @loc.valid?
  end

  test "arrival should be present" do
  	@loc.arrival = nil
  	assert_not @loc.valid?
  end

  test "departure should be present" do
  	@loc.departure = nil
  	assert_not @loc.valid?
  end
end
