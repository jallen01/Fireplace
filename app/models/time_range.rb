require 'simple_time'

class TimeRange < ActiveRecord::Base

  # Constants
  # ---------

  NAME_MAX_LENGTH = 30
  

  # Attributes
  # ----------

  belongs_to :user

  has_many :tag_time_ranges
  has_many :tags, through: :tag_time_ranges
  belongs_to :parent_tag, class_name: :Tag

  serialize :time_set, SortedSet

  # Initialize serialized object
  after_initialize do
    if self.time_set.nil?
      self.time_set = SortedSet.new
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
    self.time_set.empty?
  end

  # Returns true if this has a parent tag.
  def hidden?
    !self.parent_tag.nil?
  end
  
  def update_times(times)
    self.time_set.clear
    self.time_set.merge(times)

    self.save
  end

  def include_time?(time)
    self.time_set.include?(SimpleTime.new(time.hour, 0))
  end
  
  # Returns true if time_set is empty or time is in time_set.
  def include_time_or_empty?(time)
    self.include_time?(time) || self.time_set.empty?
  end
end
