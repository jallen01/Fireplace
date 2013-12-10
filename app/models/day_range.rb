# Model to store a set of days. Must have a name unless a parent_tag is assigned.

require 'simple_day'

class DayRange < ActiveRecord::Base

  # Constants
  # ---------

  NAME_MAX_LENGTH = 10


  # Attributes
  # ----------

  belongs_to :user

  # Used when attaching day range to tags
  has_many :tag_day_ranges
  has_many :tags, through: :tag_day_ranges

  # Used if this is a hidden day range associated with a tag
  belongs_to :parent_tag, class_name: :Tag

  serialize :day_set, SortedSet

  # Initialize serialized object
  after_initialize do
    if self.day_set.nil?
      self.day_set = SortedSet.new
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
    self.day_set.empty?
  end

  # Returns true if this has a parent tag.
  def hidden?
    !self.parent_tag.nil?
  end

  def update_days(days)
    self.day_set.clear()
    self.day_set.merge(days)

    self.save
  end

  def include_day?(day)
    self.day_set.include?(day)
  end

  # Returns true if day_set is blank or day is in day_set.
  def include_day_or_empty?(day)
    self.include_day?(day) || self.day_set.empty?
  end
end
