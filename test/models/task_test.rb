require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  
  # tasks can be made
  test "basic save" do
  	u = users(:user1)
  	ti = "FunTask"
  	ta = Task.new(user: u, title: ti)
  	assert(ta.save, "Could not save basic Task")
  end

  # tasks need a user
  test "requires user" do
  	ti = "FunTask"
    ta = Task.new(title: ti)
    assert(!ta.save, "Saved a Task without a User")
  end

  # tasks need a title
  test "requires title" do
  	u = users(:user1)
    ta = Task.new(user: u)
    assert(!ta.save, "Saved a Task without a title")
  end

  # task titles cannot be too long
  test "title length limit" do
  	u = users(:user1)
  	ti = "ThisTitleForATaskIsWayTooLongAndIDontKnowWhyImWritingRealWordsForThisButWhateverItsAnEasterEgg"
  	ta = Task.new(user: u, title: ti)
  	assert(!ta.save, "Saved a Task with too long a title")
  end

  # tasks must be unique within a user
  test "title uniqueness" do
  	u = users(:user1)
  	ti = "FunTask"
  	ta1 = Task.new(user: u, title: ti)
  	ta1.save
  	ta2 = Task.new(user: u, title: ti)
  	assert(!ta2.save, "Saved a Task with same title as existing Task")
  end

  # unit test for Task.update_tags method
  test "update tags" do
  	u = users(:user1)
  	ti = "FunTask"
  	ta = Task.new(user: u, title: ti)
  	tag = tags(:tag1)
  	ta.update_tags([tag])
  	assert(ta.tags.to_a.map { |tag| tag.name } .include?("tag1name"),
  		"ta.tags should contain Tag tag1name, but does not")
  end

  # unit test for Task.update_metadata method
  test "update metadata" do
  	u = users(:user1)
  	ti1 = "FunTask"
  	ta1 = Task.new(user: u, title: ti1)
  	tags = [tags(:tag1)]
  	md1 = { tags: tags, day_ranges: [], time_ranges: [], day_range_select: [], time_range_select: [] }
  	ta1.update_metadata(md1)
  	assert(ta1.tags.to_a.map { |tag| tag.name } .include?("tag1name"),
  		"ta1.tags should contain Tag tag1name, but does not")
  	ti2 = "PrettyFunTask"
  	ta2 = Task.new(user: u, title: ti2)
  	drs = [DayRange.new(user: u, name: "dr1")]
  	trs = [TimeRange.new(user: u, name: "tr1")]
  	md2 = { tags: [], day_ranges: drs, time_ranges: trs, day_range_select: [], time_range_select: [] }
  	ta2.update_metadata(md2)
  	assert(ta2.hidden_tag.day_ranges.map { |dr| dr.name } .include?("dr1"),
  		"ta2's hidden tag does not have the added day range")
  	assert(ta2.hidden_tag.time_ranges.map { |tr| tr.name } .include?("tr1"),
  		"ta2's hidden tag does not have the added time range")
  end

  # unit test for Task.relevant? method
  test "relevant?" do
  	u = users(:user1)
  	ti1 = "FunTask"
  	dl1 = Time.now.to_date+7
  	dn1 = 14
  	ta1 = Task.new(user: u, title: ti1, deadline: dl1, days_notice: dn1)
  	date1 = Time.now.to_date
  	time1 = SimpleTime.new(Time.now.hour, Time.now.min)
  	day1 = SimpleDay.new(Time.now.wday)
  	loc1 = locations(:location1)
  	uc1 = { date: date1, time: time1, day: day1, location: loc1 }
  	assert(ta1.relevant?(uc1), "Task should be relevant, but was considered irrelevant")
  	ti2 = "PrettyFunTask"
  	dl2 = Time.now.to_date+7
  	dn2 = 3
  	ta2 = Task.new(user: u, title: ti2, deadline: dl2, days_notice: dn2)
  	date2 = Time.now.to_date
  	time2 = SimpleTime.new(Time.now.hour, Time.now.min)
  	day2 = SimpleDay.new(Time.now.wday)
  	loc2 = locations(:location1)
  	uc2 = { date: date2, time: time2, day: day2, location: loc2 }
  	assert_not(ta2.relevant?(uc2), "Task should not be relevant, but was considered relevant")
  end

end
