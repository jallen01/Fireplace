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
end
