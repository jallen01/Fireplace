require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # user can be made
  test "basic save" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	assert(u.save, "Could not save basic User")
  end

  # users need a first name
  test "requires last name" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, last_name: ln)
  	assert(!u.save, "Saved a User without a firstname")
  end

  # users need a last name
  test "requires first name" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn)
  	assert(!u.save, "Saved a User without a lastname")
  end

  # user first names and last names cannot be too long
  test "first and last name length limit" do
  	em1 = "blooby@blib.blub"
  	pw1 = "supersafe"
  	fn1 = "BobBaBaBobBaBobBobBaBobOohWahOohWahOohWahBOB"
  	ln1 = "Bean"
  	u1 = User.new(email: em1, password: pw1, password_confirmation: pw1, first_name: fn1, last_name: ln1)
  	assert(!u1.save, "Saved a User with too long a first name")
  	em2 = "blooby@blib.blub"
  	pw2 = "supersafe"
  	fn2 = "Bob"
  	ln2 = "BeanyBeanBeanBaBeanBeanBaBeanBahBahBahBEAN"
  	u2 = User.new(email: em2, password: pw2, password_confirmation: pw2, first_name: fn2, last_name: ln2)
  	assert(!u2.save, "Saved a User with too long a last name")
  end

  # unit test for creating and getting day ranges
  test "day ranges" do
    em = "blooby@blib.blub"
    pw = "supersafe"
    fn = "Bob"
    ln = "Bean"
    u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
    u.create_day_range("FaveDays")
    assert(u.day_ranges.to_a.map { |dr| dr.name } .include?("Favedays"),
      "User does not have DayRange Favedays after it was supposed to be created")
    drs = u.get_day_ranges
    assert(drs.map { |dr| dr.name } .include?("Favedays"),
      "get_day_ranges did not have DayRange Favedays, but it should have")
    assert_not(drs.map { |dr| dr.name } .include?("Terribledays"),
      "get_day_ranges had DayRange Terribledays, but it should not have")
  end

  # unit test for creating and getting time ranges
  test "time ranges" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	u.create_time_range("FaveTimes")
  	assert(u.time_ranges.to_a.map { |tr| tr.name } .include?("Favetimes"),
  		"User does not have TimeRange Favetimes after it was supposed to be created")
  	trs = u.get_time_ranges
  	assert(trs.map { |tr| tr.name } .include?("Favetimes"),
  		"get_time_ranges did not have TimeRange Favetimes, but it should have")
  	assert_not(trs.map { |tr| tr.name } .include?("Terribletimes"),
  		"get_time_ranges had TimeRange Terribletimes, but it should not have")
  end

  # unit test for creating and getting tags
  test "tags" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	u.create_tag("CoolTag")
  	assert(u.tags.to_a.map { |t| t.name } .include?("Cooltag"),
  		"User does not have Tag Cooltag after it was supposed to be created")
  	ts = u.get_tags
  	assert(ts.map { |t| t.name } .include?("Cooltag"),
  		"get_tags did not have Tag Cooltag, but it should have")
  	assert_not(ts.map { |t| t.name } .include?("Suckytag"),
  		"get_tags had Tag Suckytag, but it should not have")
  end

  # unit test for creating and getting locations
  test "locations" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	loc_name = "BestLocation"
  	u.create_location(loc_name)
  	assert(u.locations.to_a.map { |loc| loc.name } .include?("Bestlocation"),
  		"User does not have Location Bestlocation after it was supposed to be created")
  	locs = u.get_locations
  	assert(locs.map { |loc| loc.name } .include?("Bestlocation"),
  		"get_locations did not have Location Bestlocation, but it should have")
  	assert_not(locs.map { |loc| loc.name } .include?("Worstlocation"),
  		"get_locations had Location Worstlocation, but it should not have")
  end

  # unit test for creating and getting tasks
  test "tasks" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	u.create_task("CoolTask", "thanks, bro")
  	assert(u.tasks.to_a.map { |t| t.title } .include?("Cooltask"),
  		"User does not have Task Cooltask after it was supposed to be created")
  	ts = u.get_tasks
  	assert(ts.map { |t| t.title } .include?("Cooltask"),
  		"get_tasks did not have Task Cooltask, but it should have")
  	assert_not(ts.map { |t| t.title } .include?("Suckytask"),
  		"get_tasks had Task Suckytask, but it should not have")
  end

  # unit test for User.get_context method
  test "get context" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	loc = locations(:location1)
  	right_now = Time.now
  	utc_offset = right_now.gmt_offset
  	c = u.get_context({}, loc, utc_offset)
  	assert_equal(Time.now.to_date, c[:date], "Incorrect date for regular context")
  	assert_equal(SimpleTime.new(Time.now.hour, Time.now.min), c[:time], "Incorrect time for regular context")
  	assert_equal(SimpleDay.new(Time.now.wday), c[:day], "Incorrect day for regular context")
  	c_now = u.get_context(:now, loc, utc_offset)
  	assert_equal(Time.now.to_date, c_now[:date], "Incorrect date for now context")
  	assert_equal(SimpleTime.new(Time.now.hour, Time.now.min), c_now[:time], "Incorrect time for now context")
  	assert_equal(SimpleDay.new(Time.now.wday), c_now[:day], "Incorrect day for regular context")
  	c_today = u.get_context(:today, loc, utc_offset)
  	assert_equal(Time.now.to_date, c_today[:date], "Incorrect date for today context")
	  assert_nil(c_today[:time], "Non nil time for today context")
	  assert_equal(SimpleDay.new(Time.now.wday), c_today[:day], "Incorrect day for today context")
	  assert_nil(c_today[:location], "Non nil location for today context")
  	c_tomorrow = u.get_context(:tomorrow, loc, utc_offset)
  	assert_equal(Time.now.to_date+1, c_tomorrow[:date], "Incorrect date for tomorrow context")
  	assert_nil(c_tomorrow[:time], "Non nil time for tomorrow context")
  	assert_equal(SimpleDay.new(Time.now.wday).succ, c_tomorrow[:day], "Incorrect day for tomorrow context")
  	assert_nil(c_today[:location], "Non nil location for today context")
  	c_week = u.get_context(:week, loc, utc_offset)
  	assert_nil(c_week[:time], "Non nil time for week context")
  	assert_nil(c_week[:day], "Non nil day for week context")
  	assert_nil(c_week[:location], "Non nil location for today context")
  end

end
