# Primary Author: Jonathan Allen (jallen01)
class Tag < ActiveRecord::Base

  # Constants
  # ---------

  NAME_MAX_LENGTH = 10


  # Attributes
  # ----------

  belongs_to :user

  # Optional relation for assigning a tag to a task. If task is not nil, then tag is hidden in the UI and cannot be edited directly.
  belongs_to :parent_task, class_name: :Task
    
  has_many :tag_locations, dependent: :destroy
  has_many :locations, through: :tag_locations

  has_many :tag_time_ranges, dependent: :destroy
  has_many :time_ranges, through: :tag_time_ranges
  has_one :hidden_time_range, class_name: :TimeRange, foreign_key: :parent_tag_id, dependent: :destroy, autosave: true

  has_many :tag_day_ranges, dependent: :destroy
  has_many :day_ranges, through: :tag_day_ranges
  has_one :hidden_day_range, class_name: :DayRange, foreign_key: :parent_tag_id, dependent: :destroy, autosave: true


  after_initialize do
    if self.hidden_time_range.blank?
      self.hidden_time_range = TimeRange.new(parent_tag_id: self)
    end
    if self.hidden_day_range.blank?
      self.hidden_day_range = DayRange.new(parent_tag_id: self)
    end
  end


  # Validations
  # -----------

  # validates :user, presence: true
  # validates :hidden_time_range, presence: true
  # validates :hidden_day_range, presence: true

  # validates :name, presence: true, length: { maximum: Tag::NAME_MAX_LENGTH }, uniqueness: { scope: :user }, unless: :hidden?


  # Methods
  # -------

  # Returns true if this has a parent task.
  def hidden?
    !self.parent_task.blank?
  end

  def add_day_range(day_range)
    TagDayRange.create(tag: self, day_range: day_range)
  end

  def include_day?(day)
    if self.day_ranges.blank?
      return self.hidden_day_range.include_day?(day)
    else
      return self.day_ranges.any? { |day_range| day_range.include_day?(day) }
    end
  end

  def add_time_range(time_range)
    TagTimeRange.create(tag: self, time_range: time_range)
  end

  def include_time?(time)
    if self.time_ranges.blank?
      return self.hidden_time_range.include_time?(time)
    else
      return self.time_ranges.any? { |time_range| time_range.include_time?(time) }
    end
  end

  def add_location(location)
    TagLocation.create(tag: self, location: location)
  end

  def include_location?(location)
    self.locations.blank? || self.locations.exists?(location)
  end

  def clear
    self.hidden_day_range.clear
    self.tag_day_ranges.destroy_all
    self.hidden_time_range.clear
    self.tag_time_ranges.destroy_all
    self.locations = []
    self.save
  end

  # TODO
  def update_metadata(metadata)
    if metadata[:day_ranges]
      metadata[:day_ranges].each(&self.add_day_range)
    else
      self.hidden_day_range.update_from_array(metadata[:form_day_range])
    end

    if metadata[:time_ranges] 
      metadata[:time_ranges].each(&self.add_time_range)
    else
      self.hidden_time_range.update_from_array(metadata[:form_time_range])
    end

    metadata[:locations].each(&self.add_location)
    self.save
  end

  def relevant?(time, day, location)
    result = true
    result &&= self.include_location?(location) || location.blank?
    result &&= self.include_day?(day) || day.blank?
    result &&= self.include_time?(time) || time.blank?
    
    result
  end
end