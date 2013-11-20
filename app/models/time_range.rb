# Primary Author: Jonathan Allen (jallen01)

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

  def clear
    self.time_set.clear
    
    self.save
  end

  # 'array' should be an array of boolean values of length 7. 
  def update_times(times)
    self.time_set.clear
    self.time_set.merge(time)

    self.save
  end

  # Returns true if time_set is empty or time is in time_set.
  def include_time?(time)
    self.time_set.include?(SimpleTime.new(time.hour, 0))
  end

  def include_time_or_empty?(time)
    self.include_time?(time) || self.time_set.blank?
  end
end
