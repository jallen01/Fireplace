# Primary Author: Jonathan Allen (jallen01)

require 'simple_time'

class TimeRange < ActiveRecord::Base

  # Constants
  # ---------

  NAME_MAX_LENGTH = 10
  

  # Attributes
  # ----------

  belongs_to :user

  has_many :tag_time_ranges
  has_many :tags, through: :tag_time_ranges
  belongs_to :parent_tag, class_name: :Tag

  serialize :time_set, SortedSet

  # Initialize serialized object
  after_initialize do
    if self.time_set.blank?
      self.time_set = SortedSet.new
    end
  end


  # Validations
  # -----------

  # validates :user, presence: true

  # validates :name, presence: true, length: { maximum: TimeRange::NAME_MAX_LENGTH }, uniqueness: { scope: :user }, unless: :hidden?


  # Methods
  # -------

  # Returns true if this has a parent tag.
  def hidden?
    !self.parent_tag.blank?
  end
  
  def add_time(start_t, end_t)
    self.time_set.merge(start_t..end_t)
    self.save
  end

  def remove_time(start_t, end_t)
    self.time_set.subtract(start_t..end_t)
    self.save
  end

  def clear
    self.time_set.clear
    self.save
  end

  # 'array' should be an array of boolean values of length 7. 
  def update_from_array(array)
    n = array.length
    self.clear
    times = SimpleTime.linspace(0, SimpleTime.new(0, 0), SimpleTime.new(24, 0))
    array.each_index { |i| self.add_time(times[i]) if array[i] }
    self.save
  end

  # Get array of n tuples, each containing [time, boolean], where the time values are equally spaced in the range [0, 24) and the boolean indicates whether the time is in this time range.
  def get_array(n)
    SimpleTime.linspace(SimpleTime.new(0, 0), SimpleTime.new(24, 0), n).map { |time| [time, self.time_set.include?(time)] }
  end

  # Returns true if time_set is empty or time is in time_set.
  def include_time?(time)
    self.time_set.include?(time) || self.time_set.blank?
  end
end
