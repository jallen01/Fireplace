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
  def update_metadata(tags, day_ranges, form_day_range, time_range, form_time_range, locations)
    self.clear_metadata

    # If no attached tags, update hidden tag metadata.
    if tags == nil || tags.size == 0
      self.hidden_tag.update_metadata(day_ranges, form_day_range, time_range, form_time_range, locations)
    # Else, update tags list
    else
      tags.each(&self.add_tag)
    end

    self.save
  end

  #def update_metadata(tags, metadata)
  #  self.clear_metadata

    # If no attached tags, update hidden tag metadata.
  #  if tags == nil
  #    self.hidden_tag.update_metadata(metadata)
    # Else, update tags list
  #  else
  #    tags.each(&self.add_tag)
  #  end

  #  self.save
  #end

  # Returns true if task is relevant for specified date, time, day, and location. Any nil arguments are ignored.
  def relevant?(date, time, day, location)
    result = true
    result &&= (date - self.deadline) < self.days_notice || (date && self.deadline).blank?

    if self.tags
      self.tags.each { |tag| tag.relevant?(date, time, day, location) }
    else
      self.hidden_tag.relevant?(date, time, day, location)
    end
    
    result
  end
end
