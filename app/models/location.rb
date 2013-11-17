# Primary Author: Jonathan Allen (jallen01)

# Model to store a location address. Automatically generates latitude and longitude attributes from address.
class Location < ActiveRecord::Base

  # Constants
  # ---------

  # All allowed address fields
  ADDRESS_FIELDS_ALL = [:street, :city, :state, :country]

  # Address fields shown in address string
  ADDRESS_FIELDS_SHOW = [:street, :city, :state, :country]

  NAME_MAX_LENGTH = 10


  # Attributes
  # ----------

	belongs_to :user

	has_many :tag_locations
	has_many :tags, through: :tag_locations

  serialize :address_hash, class_name: Hash

  # Initialize serialized object
  after_initialize do
    if self.address_hash.blank?
      self.address_hash = Hash.new
    end
  end

	geocoded_by :address

  # Returns string representation of address_data. Includes all fields with keys in ADDRESS_FIELDS_SHOW that aren't nil.
  def address
    ADDRESS_FIELDS_SHOW.map { |key| self.address_hash[key] }.compact.join(", ")
  end


  # Validations
  # -----------

  # validates :user, presence: true

  # validates :name, presence: true, length: { maximum: Location::NAME_MAX_LENGTH }, uniqueness: { scope: :user }

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
  
end