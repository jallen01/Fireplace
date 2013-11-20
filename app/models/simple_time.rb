# Simple object representation of a time of day. Includes hour and minute. Okay if hour is negative or larger than 24. Automatically modifies hour and minute so that 0 <= minute < 60. Immutable.
class SimpleTime 
  include Comparable

  attr_reader :hour, :minute

  def initialize(hour, minute)
    @hour = hour
    @minute = minute

    fix_minute
  end

  def self.day_hours
    (0...24).map { |i| SimpleTime.new(i, 0) }
  end

  # Compare times with assumption that 1 hour = 60 min.
  def <=>(other)
    (@hour*60 + @minute) <=> (other.hour*60 + other.minute)
  end

  def eql?(other)
    (@hour*60 + @minute) == (other.hour*60 + other.minute)
  end

  def hash
    (@hour*60 + @minute).hash
  end

  # Get time a minute later. Used for Range.
  def succ
    SimpleTime.new(@hour, @minute+1)
  end

  def add(time)
    SimpleTime.new(@hour + time.hour, @minute + time.minute)
  end

  def +(time)
    add(time)
  end

  def subtract(time)
    SimpleTime.new(@hour - time.hour, @minute - time.minute)
  end

  def -(time)
    subtract(time)
  end

  def to_s
    "#{hour}:#{minute}"
  end

  def to_time
    Time.parse(to_s)
  end

  def inspect
    "#<SimpleTime: #{hour}:#{minute}>"
  end

  private

    # Modifies hour and minute so that 0 <= minute < 60
    def fix_minute
      @hour += minute / 60
      @minute = minute % 60
    end
end