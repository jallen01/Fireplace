class Task < ActiveRecord::Base
  
  # Attributes
  # ----------

  belongs_to :user
  has_one :tag

  after_create do
    self.tag = Tag.create
    self.save
  end

  # Validations
  # -----------

  TITLE_MAX_LENGTH = 30
  validates :name, presence: true, length: { maximum: Task::TITLE_MAX_LENGTH }, uniqueness: { scope: :user }

end
