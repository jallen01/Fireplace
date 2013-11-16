# Primary Author: Jonathan Allen (jallen01)
class DayRange < ActiveRecord::Base

  # Constants
  # ---------

  NAME_MAX_LENGTH = 10


  # Attributes
  # ----------
  belongs_to :user

  has_many :tag_day_ranges
  has_many :tags, through: :tag_day_ranges
  belongs_to :parent_tag, class_name: :Tag

  serialize :day_set, SortedSet

  # Initialize serialized object
  after_initialize do
    if self.day_set.blank?
      self.day_set = SortedSet.new
    end
  end


  # Validations
  # -----------

  # validates :user, presence: true

  # validates :name, presence: true, length: { maximum: DayRange::NAME_MAX_LENGTH }, uniqueness: { scope: :user }, unless: :hidden?


  # Methods
  # -------

  # Returns true if this is a hidden day range associated with a tag
  def hidden?
    !self.parent_tag.blank?
  end

  def add_day(day)
    self.day_set.add(day)
    self.save
  end

  def remove_day(day)
    self.day_set.delete(day)
    self.save
  end

  def clear
    self.day_set.clear()
    self.save
  end

  def include_day?(day)
    if self.day_set.blank?
      return true
    else
      self.day_set
      return self.day_set.include?(day)
    end
  end
end
