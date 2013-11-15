# Simple object representation of a week day. Immutable.
class SimpleDay
  include Comparable

  DAYS = Date::DAYNAMES
  # Used to compare days (Sunday=0, Saturday=7)
  attr_reader :day_index

  # str should be a valid day name. String case is ignored.
  def initialize(str)
    index = DAYS.index(str.capitalize)
    throw TypeError, "invalid day" unless index

    @day_index = index
  end

  # Compare days based on day_index.
  def <=>(other)
    @day_index <=> other.day_index
  end

  def to_s
    SimpleDay::DAYS[@day_index]
  end

  def inspect
    "#<SimpleDay: #{to_s}>"
  end
end