require 'test_helper'

class TimeRangeTest < ActiveSupport::TestCase

  # time ranges can be made
  test "basic save" do
  	u = users(:user1)
  	n = "FaveTimes"
  	tr = TimeRange.new(user: u, name: n)
  	assert(tr.save, "Could not save basic TimeRange")
  end

  # time ranges need a user
  test "requires user" do
  	n = "FaveTimes"
    tr = TimeRange.new(name: n)
    assert(!tr.save, "Saved a TimeRange without a User")
  end

  # time ranges need a name
  test "requires name" do
  	u = users(:user1)
    tr = TimeRange.new(user: u)
    assert(!tr.save, "Saved a TimeRange without a name")
  end

  # time range names cannot be too long
  test "name length limit" do
  	u = users(:user1)
  	n = "ThisNameForATimeRangeIsWayTooLongAndIDontKnowWhyImWritingRealWordsForThisButWhateverItsAnEasterEgg"
  	tr = TimeRange.new(user: u, name: n)
  	assert(!tr.save, "Saved a TimeRange with too long a name")
  end

  # time ranges must be unique within a user
  test "name uniqueness" do
  	u = users(:user1)
  	n = "FaveTimes"
  	tr1 = TimeRange.new(user: u, name: n)
  	tr1.save
  	tr2 = TimeRange.new(user: u, name: n)
  	assert(!tr2.save, "Saved a TimeRange with same name as existing TimeRange")
  end

  # unit test for TimeRange.hidden?
  test "hidden?" do
    u = users(:user1)
    t = tags(:tag1)
    n = "FaveTimes"
    tr1 = TimeRange.new(user: u, name: n, parent_tag: t)
    assert(tr1.hidden?, "TimeRange with parent Tag was not hidden")
    tr2 = TimeRange.new(user: u, name: n)
    assert_not(tr2.hidden?, "TimeRange without parentTag was hidden")
  end

  # unit test for TimeRange.update_times method
  test "update_times" do
    u = users(:user1)
    n = "FaveTimes"
    tr = TimeRange.new(user: u, name: n)
    tr.update_times([SimpleTime.new(23, 0)])
    (0...23).each do |numbah|
      assert_not(tr.include_time?(SimpleTime.new(numbah, 0)), "SimpleTime(#{numbah}, 0) is in time_set, but should not be")
    end
    assert(tr.include_time?(SimpleTime.new(23, 0)), "SimpleTime(23, 0) should be in time_set, but is not")
  end

  # unit test for TimeRange.include_time_or_empty? method
  test "include time or empty?" do
    u = users(:user1)
    n = "FaveTimes"
    tr1 = TimeRange.new(user: u, name: n)
    tr1.time_set = SortedSet.new([SimpleTime.new(23, 0)])
    (0...23).each do |numbah|
      assert_not(tr1.include_time?(SimpleTime.new(numbah, 0)),
      	"SimpleTime(#{numbah}) is not in time_set, but was incorrectly said to be")
    end
    assert(tr1.include_time_or_empty?(SimpleTime.new(23, 0)),
    	"SimpleTime(23) is in time_set, but was incorrectly said not to be")
    tr2 = TimeRange.new(user: u, name: n)
    (0...24).each do |numbah|
      assert(tr2.include_time_or_empty?(SimpleTime.new(numbah, 0)),
        "time_set was not recognized to be empty")
    end
  end

end
