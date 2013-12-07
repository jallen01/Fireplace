require 'test_helper'
require 'simple_day'

class DayRangeTest < ActiveSupport::TestCase

  # day range can be made
  test "basic save" do
  	u = users(:user1)
  	n = "FaveDays"
  	dr = DayRange.new(user: u, name: n)
  	assert(dr.save, "Could not save basic DayRange")
  end

  # day ranges need a user
  test "requires user" do
    n = "FaveDays"
    dr = DayRange.new(name: n)
    assert(!dr.save, "Saved a DayRange without a User")
  end

  # day ranges need a name
  test "requires name" do
  	u = users(:user1)
    dr = DayRange.new(user: u)
    assert(!dr.save, "Saved a DayRange without a name")
  end

  # day range names cannot be too long
  test "name length limit" do
  	u = users(:user1)
  	n = "ThisNameForADayRangeIsWayTooLongAndIDontKnowWhyImWritingRealWordsForThisButWhateverItsAnEasterEgg"
  	dr = DayRange.new(user: u, name: n)
  	assert(!dr.save, "Saved a DayRange with too long a name")
  end

  # day ranges must be unique within a user
  test "name uniquess" do
  	u = users(:user1)
  	n = "FaveDays"
  	dr1 = DayRange.new(user: u, name: n)
  	dr1.save
  	dr2 = DayRange.new(user: u, name: n)
  	assert(!dr2.save, "Saved a DayRange with same name as existing DayRange")
  end

  # unit test for DayRange.hidden? method
  test "hidden?" do
    u = users(:user1)
    t = tags(:tag1)
    n = "FaveDays"
    dr1 = DayRange.new(user: u, name: n, parent_tag: t)
    assert(dr1.hidden?, "DayRange with parent Tag was not hidden")
    dr2 = DayRange.new(user: u, name: n)
    assert_not(dr2.hidden?, "DayRange without parentTag was hidden")
  end

  # unit test for DayRange.update_days method
  test "update_days" do
    u = users(:user1)
    n = "FaveDays"
    dr = DayRange.new(user: u, name: n)
    dr.update_days([SimpleDay.new(6)])
    (0...6).each do |numbah|
      assert_not(dr.include_day?(SimpleDay.new(numbah)),
        "SimpleDay(#{numbah}) is in day_set, but should not be")
    end
    assert(dr.include_day?(SimpleDay.new(6)), "SimpleDay(6) should be in day_set, but is not")
  end

  # unit test for DayRange.include_day_or_empty? method
  test "include day or empty" do
    u = users(:user1)
    n = "FaveDays"
    dr1 = DayRange.new(user: u, name: n)
    dr1.day_set = SortedSet.new([SimpleDay.new(6)])
    (0...6).each do |numbah|
      assert_not(dr1.include_day_or_empty?(SimpleDay.new(numbah)),
        "SimpleDay(#{numbah}) is not in day_set, but was incorrectly said to be")
    end
    assert(dr1.include_day_or_empty?(SimpleDay.new(6)),
      "SimpleDay(23) is in day_set, but was incorrectly said not to be")
    dr2 = DayRange.new(user: u, name: n)
    (0...7).each do |numbah|
      assert(dr2.include_day_or_empty?(SimpleDay.new(numbah)),
        "day_set was not recognized to be empty")
    end
  end
end
