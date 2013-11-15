# Simple object representation of a time of day. Includes hours and minutes. Okay if hours is negative or larger than 24. Automatically modifies hours and minutes so that 0 <= minutes < 60. Immutable.
class SimpleTime 
  include Comparable

  attr_reader :hours, :minutes

  def initialize(hours, minutes)
    @hours = hours
    @minutes = minutes

    fix_minutes
  end

  # Compare times with assumption that 1 hour = 60 min.
  def <=>(other)
    (@hours*60 + @minutes) <=> (other.hours*60 + other.minutes)
  end

  # Get time a minute later. Used for Range.
  def succ
    return SimpleTime(@hours, @minutes+1)
  end

  def +(time)
    return SimpleTime.new(@hours + time.hours, @minutes + time.minutes)
  end

  def -(time)
    return SimpleTime.new(@hours - time.hours, @minutes - time.minutes)
  end

  def to_s
    "#{hours}:#{minutes}"
  end

  def inspect
    "#<SimpleTime: #{hours}:#{minutes}>"
  end

  private

    # Modifies hours and minutes so that 0 <= minutes < 60
    def fix_minutes
      @hours += minutes / 60
      @minutes = minutes % 60
    end
end