# Simple object representation of a week day. Immutable.
class SimpleDay
  include Comparable

  DAY_NAMES = Date::DAYNAMES
  # Used to compare days (Sunday=0, Saturday=7)
  attr_reader :day_int

  # str should be a valid day name. String case is ignored.
  def initialize(day_int)
    throw RangeError, "Invalid day" unless (day_int >=0 && day_int < 7)
    @day_int = day_int
  end

  # 'day_name' must be in DAY_NAMES (case ignored).
  def self.from_s(day_name)
    day_int = SimpleDay::DAY_NAMES.index(day_name.capitalize)
    SimpleDay(day_int)
  end

  def self.week_days
    (0...7).map { |i| SimpleDay.new(i) }
  end

  # Get next day. Wraps around, so next day after Saturday is Sunday.
  def succ
    SimpleDay.new((@day_int + 1) % 7)
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

  def to_date
    Date.parse(to_s)
  end

  def to_s
    SimpleDay::DAY_NAMES[@day_int]
  end

  def to_s_abbrev
    to_date.strftime("%a")
  end

  def inspect
    "#<SimpleDay: #{to_s}>"
  end
end