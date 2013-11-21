# Primary Author: Jonathan Allen (jallen01)
class Task < ActiveRecord::Base

  # Constants
  # ---------

  # Filter policies
  POLICIES = [:show_only_important, :show_long_lasting]

  # Filter time frame
  TIME_FRAMES = [:now, :today, :tomorrow, :week]

  TITLE_MAX_LENGTH = 30

  
  # Attributes
  # ----------

  belongs_to :user

  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  # Used to store task specific metadata
  has_one :hidden_tag, class_name: :Tag, foreign_key: :parent_task_id, dependent: :destroy, autosave: true

  # Create hidden tag
  after_initialize do
    if self.hidden_tag.blank?
      self.hidden_tag = Tag.new(user: self.user, parent_task: self)
    end
  end

  # Validations
  # -----------

  validates :user, presence: true
  
  validates :title, presence: true, length: { maximum: Task::TITLE_MAX_LENGTH }, uniqueness: { scope: :user }


  # Methods
  # -----------

  def update_tags(tags)
    self.task_tags.destroy_all
    self.save

    tags.each { |tag| TaskTag.create(task: self, tag: tag) }
  end

  def update_metadata(metadata)
    self.update_tags(metadata[:tags])
    self.hidden_tag.update_metadata(metadata)
  end

  # Returns true if task is relevant for specified date, time, day, and location. Any nil arguments are ignored.
  def relevant?(date, time, day, location)
    result = true

    # if a deadline has been set is the deadline soon enough to show the task?
    result &&= (self.deadline.blank? || ((date - self.deadline) < self.days_notice))


    if self.tags.blank?
      result &&= self.hidden_tag.relevant?(time, day, location)
    else
      result &&= self.tags.any? { |tag| tag.relevant?(time, day, location) }
    end
    
    result
  end
end
