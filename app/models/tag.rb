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
    if self.hidden_time_range.nil?
      self.hidden_time_range = TimeRange.new(user: self.user, parent_tag: self)
    end
    if self.hidden_day_range.nil?
      self.hidden_day_range = DayRange.new(user: self.user, parent_tag: self)
    end
  end

  scope :ordered, -> { order(:name) }


  # Validations
  # -----------

  validates :user, presence: true

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }, uniqueness: { scope: :user }, unless: :hidden?

  # Capitalize first letter of each word in name
  before_validation do
    unless name.nil?
      self.name = self.name.downcase.split.map(&:capitalize).join(' ') 
    end
  end 


  # Methods
  # -------

  def empty?
    result = true

    result &&= self.day_ranges.empty?
    result &&= self.hidden_day_range.empty?
    result &&= self.time_ranges.empty?
    result &&= self.hidden_time_range.empty?
    result &&= self.locations.empty?

    result
  end

  # Returns true if this has a parent task.
  def hidden?
    self.parent_task.present?
  end

  def update_day_ranges(day_ranges)
    self.tag_day_ranges.destroy_all
    day_ranges.each { |day_range| TagDayRange.create(tag: self, day_range: day_range) }

    self.save
  end

  def include_day?(day)
    if self.day_ranges.present?
      return self.day_ranges.any? { |day_range| day_range.include_day_or_empty?(day) }
    else
      return self.hidden_day_range.include_day_or_empty?(day)
    end
  end

  def update_time_ranges(time_ranges)
    self.tag_time_ranges.destroy_all
    time_ranges.each { |time_range| TagTimeRange.create(tag: self, time_range: time_range) }

    self.save
  end

  def include_time?(time)
    if self.time_ranges.present?
      return self.time_ranges.any? { |time_range| time_range.include_time_or_empty?(time) }
    else
      return self.hidden_time_range.include_time_or_empty?(time)
    end
  end

  def update_locations(locations)
    self.tag_locations.destroy_all
    locations.each { |location| TagLocation.create(tag: self, location: location) }

    self.save
  end

  def include_location?(location)
    self.locations.blank? || self.locations.exists?(location)
  end

  def update_metadata(metadata)
    self.update_day_ranges(metadata[:day_ranges])
    self.update_time_ranges(metadata[:time_ranges])
    self.update_locations(metadata[:locations])

    self.hidden_day_range.update_days(metadata[:day_range_select])
    self.hidden_time_range.update_times(metadata[:time_range_select])
  end

  def relevant?(user_context)
    result = true
    result &&= (user_context[:location].blank? || self.include_location?(user_context[:location]))
    result &&= (user_context[:day].blank? || self.include_day?(user_context[:day]))
    result &&= (user_context[:time].blank? || self.include_time?(user_context[:time]))
    
    result
  end
end