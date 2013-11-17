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
  has_one :hidden_tag, class_name: :Tag, foreign_key: :parent_task_id, dependent: :destroy, autosave: true

  # Create hidden tag for storing task metadata
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

  def update_metadata(metadata)

    metadata[:day_range]
    metadata[:time_range]
    metadata[:locations]
    metadata[:tags]

  end

  def relevant?(time, day, location)
    result = true
    result &&= self.tag.include_time?(time) if time
    result &&= self.tag.include_day?(day) if day
    result &&= self.tag.include_location?(location) if location
    
    result
  end
end
