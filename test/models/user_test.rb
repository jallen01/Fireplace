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

end
