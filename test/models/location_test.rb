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
  test "name uniqueness" do
  	u = users(:user1)
  	n = "FaveLocation"
  	l1 = Location.new(user: u, name: n)
  	l1.save
  	l2 = Location.new(user: u, name: n)
  	assert(!l2.save, "Saved a Location with same name as existing Location")
  end

end
