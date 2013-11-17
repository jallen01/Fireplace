# Primary Author: Jonathan Allen (jallen01)
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

  # Returns true if this is a hidden day range associated with a tag.
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

  # 'array' should be an array of boolean values of length 7. 
  def update_from_array(array)
    self.clear
    array.each_index { |i| self.add_day(SimpleDay(i)) if array[i] }
    self.save
  end

  # Returns true if day_set is blank or day is in day_set.
  def include_day?(day)
    if self.day_set.blank?
      return true
    else
      self.day_set
      return self.day_set.include?(day)
    end
  end
end
