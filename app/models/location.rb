# Primary Author: Michelle Johnson (mchlljy)

# Model to store a location address. Automatically generates latitude and longitude attributes from address.
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

  Geocoder.configure(:always_raise => [SocketError, TimeoutError, Geocoder::InvalidRequest, Geocoder::OverQueryLimitError])

  scope :ordered, -> { order(:name) }

  geocoded_by :get_address
  after_validation :geocode

  # Validations
  # -----------

  validates :user, presence: true

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }, uniqueness: { scope: :user }

  #validate :address_info_valid

  # Capitalize first letter of each word in name
  before_validation do
    unless name.nil?
      self.name = self.name.downcase.split.map(&:capitalize).join(' ') 
    end
  end

  def address_fields_to_a
    [street, city, state, zip_code]
  end

  # Methods
  # -----------

  # Distance in miles.
  def calc_distance(latitude, longitude)
    Geocoder::Calculations.distance_between([self.latitude, self.longitude], [latitude, longitude])
  end

  def get_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip_code}"
  end

  #def address_info_valid
    #logger.debug "street.isnotblank?"
    #logger.debug (street.blank? == false)
    #logger.debug "city.isnotblank?"
    #logger.debug (city.blank? == false)
    #logger.debug "state.isnotblank?"
    #logger.debug (state.blank? == false)
    #logger.debug "zip_code.isnotblank?"
    #logger.debug (zip_code.blank? == false)

    #invalid =  !(self.address_fields_to_a.all?(&:blank?)) && self.address_fields_to_a.any?(&:blank?)
    #errors.add(:base, "Need to enter all address parts") if invalid
  #end

end