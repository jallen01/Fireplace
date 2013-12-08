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
    print = t.day_ranges.to_a.map { |dr| dr.name }
  	assert(t.day_ranges.to_a.map { |dr| dr.name } .include?("Dr1"),
  		"t.day_ranges should contain DayRange Dr1, but does not")
  end

  # unit test for Tag.include_day? method
  test "include_day?" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	d = SimpleDay.new(0)
  	dr = DayRange.new(user: u, name: "dr1")
  	dr.update_days([d])
  	t.update_day_ranges([dr])
  	assert(t.include_day?(d), "Tag incorrectly says it doesn't include day 0 after it was added")
  end

  # unit test for Tag.update_time_ranges method
  test "update time ranges" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	trs = [TimeRange.new(user: u, name: "tr1")]
  	t.update_time_ranges(trs)
  	assert(t.time_ranges.to_a.map { |tr| tr.name } .include?("Tr1"),
  		"t.time_ranges should contain TimeRange Tr1, but does not")
  end

  # unit test for Tag.include_time? method
  test "include_time?" do
  	u = users(:user1)
  	n = "NiceTag"
  	t = Tag.new(user: u, name: n)
  	time = SimpleTime.new(0, 0)
  	tr = TimeRange.new(user: u, name: "tr1")
  	tr.update_times([time])
  	t.update_time_ranges([tr])
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
  	t.update_locations([l])
  	assert(t.include_location?(l),
  		"Tag incorrectly says it doesn't include Location Bestlocation after it was added")
  end

  # unit test for Tag.update_metadata method
  test "update metadata" do
  	u = users(:user1)
  	n1 = "NiceTag"
  	t1 = Tag.new(user: u, name: n1)
  	drs = [DayRange.new(user: u, name: "dr1")]
  	trs = [TimeRange.new(user: u, name: "tr1")]
  	md1 = { tags: [], day_ranges: drs, time_ranges: trs,
      day_range_select: [], time_range_select: [], locations: [] }
  	t1.update_metadata(md1)
  	assert(t1.day_ranges.to_a.map { |dr| dr.name } .include?("Dr1"),
  		"Tag does not contain DayRange Dr1 after it should have been added with update_metadata")
  	assert(t1.time_ranges.to_a.map { |tr| tr.name } .include?("Tr1"),
  		"Tag does not contain TimeRange Tr1 after it should have been added with update_metadata")
  	n2 = "PrettyNiceTag"
  	t2 = Tag.new(user: u, name: n2)
  	d = SimpleDay.new(0)
  	time = SimpleTime.new(0, 0)
  	md2 = { tags: [], day_ranges: [], time_ranges: [],
      day_range_select: [d], time_range_select: [time], locations: [] }
  	t2.update_metadata(md2)
  	assert(t2.include_day?(d),
  		"Tag does not contain day 0 after it should have been added with update_metadata")
  	assert(t2.include_time?(time),
  		"Tag does not contain time 0, 0 after it should have been added with update_metadata")
  end

  # unit test for Tag.relevant? method
  test "relevant?" do
  	u = users(:user1)
  	right_now = Time.now
  	time = SimpleTime.new(right_now.hour, right_now.min)
  	day = SimpleDay.new(right_now.wday)
  	loc = locations(:location1)
  	uc = { day: day, time: time, location: loc }
  	n1 = "NiceTag"
  	t1 = Tag.new(user: u, name: n1)
  	day1 = day
  	time1 = SimpleTime.new(time.hour, 0)
  	md1 = { day_ranges: [], time_ranges: [],
      day_range_select: [day1], time_range_select: [time1], locations: [] }
  	t1.update_metadata(md1)
  	assert(t1.relevant?(uc), "Incorrectly said t1 was not relevant when it was relevant")
  	n2 = "PrettyNiceTag"
  	t2 = Tag.new(user: u, name: n2)
  	day2 = day
  	time2 = SimpleTime.new(time.hour+3, 0)
  	md2 = { day_ranges: [], time_ranges: [],
      day_range_select: [day2], time_range_select: [time2], locations: [] }
  	t2.update_metadata(md2)
  	assert_not(t2.relevant?(uc), "Incorrectly said t2 was relevant when it was not relevant")
  	n3 = "NotGreatTag"
  	t3 = Tag.new(user: u, name: n2)
  	time3 = SimpleTime.new(time.hour, 0)
  	md3 = { day_ranges: [], time_ranges: [],
      day_range_select: [], time_range_select: [time3], locations: [] }
  	t3.update_metadata(md3)
  	assert_not(t2.relevant?(uc), "Incorrectly said t3 was not relevant when it was relevant")
  end

end
