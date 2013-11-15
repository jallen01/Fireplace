# Primary Author: Jonathan Allen (jallen01)
class Tag < ActiveRecord::Base

  # Constants
  # ---------

  NAME_MAX_LENGTH = 10


  # Attributes
  # ----------

  belongs_to :user

  # Optional relation for assigning a tag to a task. If task is not nil, then tag is hidden in the UI and cannot be edited directly.
  belongs_to :task

  serialize :day_set, SortedSet
  serialize :time_set, SortedSet

  # Initialize serialized objects
  after_initialize do
    if self.day_set.blank?
      self.day_set = SortedSet.new
    end

    if self.time_set.blank?
      self.time_set = SortedSet.new
    end
  end
    
  has_many :location_tags
  has_many :locations, through: :location_tags

  has_many :tag_relations, foreign_key: :parent_tag_id, dependent: :destroy
  has_many :reverse_tag_relations, class_name: :TagRelation,
      foreign_key: :child_tag_id, dependent: :destroy
  has_many :child_tags, :through => :tag_relations, :source => :child_tag


  # Validations
  # -----------

  validates :user, existence: true

  validates :name, presence: true, length: { maximum: Tag::NAME_MAX_LENGTH }, uniqueness: { scope: :user }, unless: :hidden?


  # Methods
  # -------

  def hidden?
    return self.task.blank?
  end

  def add_time_range(start_t, end_t)
    self.time_set.merge(start_t..end_t)
    self.save
  end

  def remove_time_range(start_t, end_t)
    self.time_set.subtract(start_t..end_t)
    self.save
  end

  def include_time?(time)
    if self.time_set.blank?
      if self.child_tags.empty?
        return true
      else
        return self.child_tags.any? { |tag| include_time?(time) }
      end
    else
      return self.time_set.include?(time)
    end
  end

  def add_day(day)
    self.day_set.add(day)
  end

  def remove_day(day)
    self.day_set.delete(day)
  end

  def include_day?(day)
    if self.day_set.blank?
      if self.child_tags.empty?
        return true
      else
        return self.child_tags.any? { |tag| include_day?(day) }
      end
    else
      return self.day_set.include?(day)
    end
  end

  def add_location(location)
    LocationTag.create(tag: self, location: location)
  end

  def include_location?(location)
    if self.day_set.blank?
      if self.child_tags.empty?
        return true
      else
        return self.child_tags.any? { |tag| include_location?(location) }
      end
    else
      return self.locations.exists?(location)
    end
  end
end