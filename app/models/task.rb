# Primary Author: Jonathan Allen (jallen01)
class Task < ActiveRecord::Base

  # Constants
  # ---------

  TITLE_MAX_LENGTH = 30

  
  # Attributes
  # ----------

  belongs_to :user
  has_one :tag

  # Create hidden tag for storing task metadata
  before_validation do
    self.tag = Tag.create
  end

  # Validations
  # -----------

  validates :user, existence: true
  validates :tag, existence: true
  
  validates :name, presence: true, length: { maximum: Task::TITLE_MAX_LENGTH }, uniqueness: { scope: :user }


  # Methods
  # -----------

  def relevant?(time, day, location)
    result = true
    result &&= self.tag.include_time?(time) if time
    result &&= self.tag.include_day?(day) if day
    result &&= self.tag.include_location?(location) if location
    return result
  end

  def 

  end
end
