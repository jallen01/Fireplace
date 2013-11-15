class Location < ActiveRecord::Base

  # Attributes
  # ----------

	belongs_to :user

	has_many :location_tags
	has_many :tags, through: :location_tags

  serialize :address_hash, class_name: :hash
	geocoded_by :address

  # All allowed address fields
  ADDRESS_FIELDS_ALL = [:street, :city, :state, :country]

  # Returns string representation of address_data. Includes all fields with keys in ADDRESS_FIELDS_SHOW that aren't nil.
  ADDRESS_FIELDS_SHOW = [:street, :city, :state, :country]
  def address
    ADDRESS_FIELDS_SHOW.map { |key| self.address_hash[key] }.compact.join(", ")
  end

  ALL_LOCATIONS_NAME = "All Locations"


  # Validations
  # -----------

  NAME_MAX_LENGTH = 10
  validates :name, presence: true, length: { maximum: Location::NAME_MAX_LENGTH }, uniqueness: { scope: :user }

  # Capitalize first letter of each word in name
  before_validation do 
    self.name = self.name.downcase.split.map(&:capitalize).join(' ') 

    # Sanitize address hash
    self.address_hash.permit(*ADDRESS_FIELDS_ALL)
    self.address_hash.each do |k, v|
      self.address_hash[k] = String(v)
    end

  end

	after_validation :geocode, if: :address_changed?


  # Methods
  # -------
  
end