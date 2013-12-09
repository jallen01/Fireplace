class Location < ActiveRecord::Base

  include ActiveModel::Validations

  # Constants
  # ---------

  NAME_MAX_LENGTH = 30


  # Attributes
  # ----------

	belongs_to :user

	has_many :tag_locations
	has_many :tags, through: :tag_locations

  scope :ordered, -> { order(:name) }

  # Validations
  # -----------

  validates :user, presence: true

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }, uniqueness: { scope: :user }

  # Capitalize first letter of each word in name
  before_validation do
    unless name.nil?
      self.name = self.name.downcase.split.map(&:capitalize).join(' ') 
    end
  end

  # Methods
  # -----------

end