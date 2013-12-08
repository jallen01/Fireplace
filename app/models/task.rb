# Primary Author: Jonathan Allen (jallen01)
class Task < ActiveRecord::Base

  # Constants
  # ---------

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
    if self.hidden_tag.nil?
      self.hidden_tag = Tag.new(user: self.user, parent_task: self)
    end
  end

  scope :ordered, -> { order(:title) }

  # Validations
  # -----------

  validates :user, presence: true
  
  validates :title, presence: true, length: { maximum: TITLE_MAX_LENGTH }, uniqueness: { scope: :user }

  # Capitalize first letter of each word in title
  before_validation do
    unless title.nil?
      self.title = self.title.downcase.split.map(&:capitalize).join(' ') 
    end
  end 


  # Methods
  # -----------

  def update_tags(tags)
    self.task_tags.destroy_all
    self.save

    tags.each { |tag| TaskTag.create(task: self, tag: tag) }
  end

  def update_metadata(metadata)
    logger.debug "my-metadata"
    logger.debug metadata
    self.update_tags(metadata[:tags])
    self.hidden_tag.update_metadata(metadata)
  end

  # Returns true if task is relevant for specified date, time, day, and location. Any nil arguments are ignored.
  def relevant?(user_context)
    result = true

    # if a deadline has been set is the deadline soon enough to show the task?
    result &&= (self.deadline.blank? || ((self.deadline - user_context[:date]) <= self.days_notice))

    if self.tags.blank?
      result &&= self.hidden_tag.relevant?(user_context)
    else
      result &&= self.tags.any? { |tag| tag.relevant?(user_context) }
    end
    
    result
  end
end
