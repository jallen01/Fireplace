require 'test_helper'

class TagTest < ActiveSupport::TestCase
  
  # tags can be made
  test "basic save" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	assert(t.save, "Could not save basic Tag")
  end

  # tags need a user
  test "requires user" do
  	n = "NiceTag"
    t = Tag.new(name: n)
    assert(!t.save, "Saved a Tag without a User")
  end

  # tags need a name
  test "requires name" do
  	u = users(:user1)
    t = Tag.new(user: u)
    assert(!t.save, "Saved a Tag without a name")
  end

  # tag names cannot be too long
  test "name length limit" do
  	u = users(:user1)
  	n = "ThisNameForATagIsWayTooLongAndIDontKnowWhyImWritingRealWordsForThisButWhateverItsAnEasterEgg"
  	t = Tag.new(user: u, name: n)
  	assert(!t.save, "Saved a Tag with too long a name")
  end

  # tags must be unique within a user
  test "name uniqueness" do
  	u = users(:user1)
  	n = "NiceTag"
  	t1 = Tag.new(user: u, name: n)
  	t1.save
  	t2 = Tag.new(user: u, name: n)
  	assert(!t2.save, "Saved a Tag with same name as existing Tag")
  end

  # unit test for Tag.empty? method
  test "empty?" do
  	u = users(:user1)
  	n1 = "NiceTag"
  	t1 = Tag.new(user: u, name: n1)
  	assert(t1.empty?, "Empty Tag incorrectly deemed not empty")
  	n2 = "PrettyNiceTag"
  	drs = [DayRange.new(user: u, name: "dr1")]
  	trs = [TimeRange.new(user: u, name: "tr1")]
  	t2 = Tag.new(user: u, name: n2, day_ranges: drs, time_ranges: trs)
  	assert_not(t2.empty?, "Tag with day ranges and time ranges incorrectly deemed empty")
  end

  # unit test for Tag.hidden? method
  test "hidden?" do
    u = users(:user1)
    n = "NiceTag"
    task = tasks(:task1)
    t1 = Tag.new(user: u, name: n, parent_task: task)
    assert(t1.hidden?, "Tag with parent Task was not hidden")
    t2 = Tag.new(user: u, name: n)
    assert_not(t2.hidden?, "Tag without parent Task was hidden")
  end

  # unit test for Tag.update_day_ranges method
  test "update day ranges" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	drs = [DayRange.new(user: u, name: "dr1")]
  	t.update_day_ranges(drs)
  	assert(t.day_ranges.to_a.map { |dr| dr.name } .include?("dr1"),
  		"t.day_ranges should contain DayRange dr1, but does not")
  end

  # unit test for Tag.include_day? method
  test "include_day?" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	d = SimpleDay.new(0)
  	dr = DayRange.new(user: u, name: "dr1")
  	dr.update_days([d])
  	drs = [dr]
  	t.update_day_ranges(drs)
  	assert(t.include_day?(d), "Tag incorrectly says it doesn't include day 0 after it was added")
  end

  # unit test for Tag.update_time_ranges method
  test "update time ranges" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	trs = [TimeRange.new(user: u, name: "tr1")]
  	t.update_time_ranges(trs)
  	assert(t.time_ranges.to_a.map { |tr| tr.name } .include?("tr1"),
  		"t.time_ranges should contain TimeRange tr1, but does not")
  end

  # unit test for Tag.include_time? method
  test "include_time?" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	time = SimpleTime.new(0, 0)
  	tr = TimeRange.new(user: u, name: "tr1")
  	tr.update_times([time])
  	trs = [tr]
  	t.update_time_ranges(trs)
  	assert(t.include_time?(time), "Tag incorrectly says it doesn't include time 0, 0 after it was added")
  end

  # unit test for Tag.update_locations method
  test "update locations" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	ls = [locations(:location1)]
  	t.update_locations(ls)
  	assert(t.locations.to_a.map { |l| l.name } .include?("Bestlocation"),
  		"t.locations should contain Location Bestlocation, but does not")
  end

  # unit test for Tag.include_location? method
  test "include_location?" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	l = locations(:location1)
  	ls = [l]
  	t.update_locations(ls)
  	assert(t.include_location?(l), "Tag incorrectly says it doesn't include time 0, 0 after it was added")
  end

  # unit test for Tag.update_metadata method
  test "update metadata" do
  	
  end

end
