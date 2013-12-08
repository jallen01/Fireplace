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

end
