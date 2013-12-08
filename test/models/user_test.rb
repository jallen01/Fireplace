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

  # unit test for creating and getting time ranges
  test "time ranges" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	u.create_time_range("FaveTimes")
  	assert(u.time_ranges.to_a.map { |tr| tr.name } .include?("FaveTimes"),
  		"User does not have TimeRange FaveTimes after it was supposed to be created")
  	trs = u.get_time_ranges
  	assert(u.get_time_ranges.map { |tr| tr.name } .include?("FaveTimes"),
  		"get_time_ranges did not have TimeRange FaveTimes, but it should have")
  	assert_not(u.get_time_ranges.map { |tr| tr.name } .include?("TerribleTimes"),
  		"get_time_ranges had TimeRange TerribleTimes, but it should not have")
  end

  # unit test for creating and getting day ranges
  test "day ranges" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	u.create_day_range("FaveDays")
  	assert(u.day_ranges.to_a.map { |dr| dr.name } .include?("FaveDays"),
  		"User does not have DayRange FaveDays after it was supposed to be created")
  	drs = u.get_day_ranges
  	assert(u.get_day_ranges.map { |dr| dr.name } .include?("FaveDays"),
  		"get_day_ranges did not have DayRange FaveDays, but it should have")
  	assert_not(u.get_day_ranges.map { |dr| dr.name } .include?("TerribleDays"),
  		"get_day_ranges had DayRange TerribleDays, but it should not have")
  end

  # unit test for creating and getting tags
  test "tags" do
  	em = "blooby@blib.blub"
  	pw = "supersafe"
  	fn = "Bob"
  	ln = "Bean"
  	u = User.new(email: em, password: pw, password_confirmation: pw, first_name: fn, last_name: ln)
  	u.create_tag("CoolTag")
  	assert(u.tags.to_a.map { |t| t.name } .include?("CoolTag"),
  		"User does not have Tag CoolTag after it was supposed to be created")
  	ts = u.tags
  	assert(u.get_tags.map { |t| t.name } .include?("CoolTag"),
  		"get_tags did not have Tag CoolTag, but it should have")
  	assert_not(u.get_tags.map { |t| t.name } .include?("SuckyTag"),
  		"get_tags had Tag SuckyTag, but it should not have")
  end

end
