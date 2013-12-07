require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  
  # locations can be made
  test "basic save" do
  	u = users(:user1)
  	n = "FaveLocation"
  	l = Location.new(user: u, name: n)
  	assert(l.save, "Could not save basic Location")
  end

  # locations need a user
  test "requires user" do
    n = "FaveLocation"
    l = Location.new(name: n)
    assert(!l.save, "Saved a Location without a User")
  end

  # locations need a name
  test "requires name" do
  	u = users(:user1)
    l = Location.new(user: u)
    assert(!l.save, "Saved a Location without a name")
  end

  # location names cannot be too long
  test "name length limit" do
  	u = users(:user1)
  	n = "ThisNameForALocationIsWayTooLongAndIDontKnowWhyImWritingRealWordsForThisButWhateverItsAnEasterEgg"
  	l = Location.new(user: u, name: n)
  	assert(!l.save, "Saved a DayRange with too long a name")
  end

  # locations must be unique within a user
  test "name uniquess" do
  	u = users(:user1)
  	n = "FaveLocation"
  	l1 = Location.new(user: u, name: n)
  	l1.save
  	l2 = Location.new(user: u, name: n)
  	assert(!l2.save, "Saved a Location with same name as existing Location")
  end

  # unit test for Location.calc_distance method
  test "within distance?" do
  	u = users(:user1)
  	n = "FaveLocation"
  	# the distance between 42N 71W and 38N 122W is about 2322 miles
  	p1, p2 = [42, -71], [38, -122]
  	d = calc_distance(p1, p2)
  	assert_in_delta(2322, d, 300, "calc_distance returned #{d} miles instead of about 2322 miles")
  end

end
