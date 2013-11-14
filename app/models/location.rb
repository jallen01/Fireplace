class Location < ActiveRecord::Base

  # Attributes
  # ----------

	belongs_to :user

	has_many :location_tags
	has_many :tags, :through => :location_tags

  serialize :address_hash, class_name: :hash
	geocoded_by :address

  # All allowed address fields
  ADDRESS_FIELDS_ALL = ['street', 'city', 'state', 'country']

  # Returns string representation of address_data. Includes all fields in ADDRESS_FIELDS_SHOW that aren't nil.
  ADDRESS_FIELDS_SHOW = ['street', 'city', 'state', 'country']
  def address
    ADDRESS_FIELDS_SHOW.map { |key| self.address_hash[key] }.compact.join(", ")
  end


  # Validations
  # -----------

  NAME_MAX_LENGTH = 10
  validates :name, presence: true, length: { maximum: Location::NAME_MAX_LENGTH }, uniqueness: { scope: :user }

  # Capitalize first letter of each word in name
  before_validation { self.name = self.name.downcase.split.map(&:capitalize).join(' ') }

	after_validation :geocode, :if => :address_changed?
  
end