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

  def hidden?
    !self.parent_tag.blank?
  end
  
  def add_time_range(start_t, end_t)
    self.time_set.merge(start_t..end_t)
    self.save
  end

  def remove_time_range(start_t, end_t)
    self.time_set.subtract(start_t..end_t)
    self.save
  end

  def clear
    self.time_set.clear
    self.save
  end

  def include_time?(time)
    if self.time_set.blank?
      return true
    else
      return self.time_set.include?(time)
    end
  end
end
