# Simple object representation of a week day. Immutable.
class SimpleDay
  include Comparable

  DAY_NAMES = Date::DAYNAMES
  # Used to compare days (Sunday=0, Saturday=7)
  attr_reader :day_int

  # str should be a valid day name. String case is ignored.
  def initialize(day_int)
    @day_int = day_int
  end

  def self.from_s(str)
    day_int = SimpleDay::DAY_NAMES.index(str.capitalize)

    day_int ? SimpleDay(day_int) : nil
  end

  # Get next day.
  def succ
    SimpleDay(@day_int + 1)
  end

  # Compare days based on day_int.
  def <=>(other)
    @day_int <=> other.day_int
  end

  def eql?(other)
    @day_int == other.day_int
  end

  def hash
    @day_int.hash
  end

  def to_s
    SimpleDay::DAY_NAMES[@day_int]
  end

  def inspect
    "#<SimpleDay: #{to_s}>"
  end
end