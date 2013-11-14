class TimeSet
  def initialize(array=[])
    @_time_set = Set.new(array)
  end

  def add_range(start_t, stop_t)
    @_time_set.merge(start_t.strftime("%H:%M")..stop_t.strftime("%H:%M"))
    nil
  end

  def remove_range(start_t, stop_t)
    @_time_set.subtract(start_t.strftime("%H:%M")..stop_t.strftime("%H:%M"))
    nil
  end

  def include?(time)
    @_time_set.include?(time.strftime("%H:%M"))
  end

  def get_discretized(n)
    ("00:00".."24:00").step((24.0*60.0/n).ceil).map do |t| 
      time = Time.parse(t)
      [time, self.include?(time)]
    end
  end

  def to_a
    @_time_set.to_a
  end
end