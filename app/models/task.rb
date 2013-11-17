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
      self.hidden_tag = Tag.new(parent_task: self)
    end
  end

  # Validations
  # -----------

  # validates :user, presence: true
  # validates :hidden_tag, presence: true
  
  # validates :name, presence: true, length: { maximum: Task::TITLE_MAX_LENGTH }, uniqueness: { scope: :user }


  # Methods
  # -----------

  def add_tag(tag)
    TaskTag.create(task: self, tag: tag)
  end

  # Remove all attached tags and clear hidden tag.
  def clear_metadata
    self.task_tags.destroy_all
    self.hidden_tag.clear
    self.save
  end

  # Update metadata and tags. Tags should have keys :form_day_range, :form_time_range, :locations (ids), :tags (ids).
  def update_metadata(metadata)
    self.clear_metadata

    # If attached tags update tag list.
    if metadata[:tags]
      metadata[:tags].each(&self.add_tag)
        tag = Tag.find_by(id: tag_id)
    # Otherwise, update hidden tag metadata.
    else
      self.hidden_tag.update_metadata(metadata)
    end

    self.save
  end

  # Returns true if task is relevant for specified date, time, day, and location. Any nil arguments are ignored.
  def relevant?(date, time, day, location)
    result = true
    result &&= (date - self.deadline) < self.days_notice if (date && self.deadline)
    result &&= self.tag.include_time?(time) if time
    result &&= self.tag.include_day?(day) if day
    result &&= self.tag.include_location?(location) if location
    
    result
  end
end
