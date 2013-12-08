# Primary Author: Michelle Johnson (mchlljy)

# Model to store a location address. Automatically generates latitude and longitude attributes from address.
class Location < ActiveRecord::Base

  # Constants
  # ---------

  # All allowed address fields
  ADDRESS_FIELDS_ALL = [:street, :city, :zip, :state]

  # Address fields shown in address string
  ADDRESS_FIELDS_SHOW = [:street, :city, :zip, :state]

  NAME_MAX_LENGTH = 30


  # Attributes
  # ----------

	belongs_to :user

	has_many :tag_locations
	has_many :tags, through: :tag_locations


  serialize :address_hash, Hash

  Geocoder.configure(:always_raise => [SocketError, TimeoutError, Geocoder::InvalidRequest, Geocoder::OverQueryLimitError])

  # Initialize serialized object
  after_initialize do
    if self.address_hash.nil?
      self.address_hash = Hash.new 
    end
  end

	geocoded_by :address

 #  Returns string representation of address_data. Includes all fields with keys in ADDRESS_FIELDS_SHOW that aren't nil.
  def address
    ADDRESS_FIELDS_SHOW.map { |key| self.address_hash[key] }.compact.join(", ")
  end


  # Validations
  # -----------

  validates :user, presence: true

  validates :name, presence: true, length: { maximum: Location::NAME_MAX_LENGTH }, uniqueness: { scope: :user }

  # Capitalize first letter of each word in name
  before_validation do
    unless name.nil?
      self.name = self.name.downcase.split.map(&:capitalize).join(' ') 
    end

    # Sanitize address hash
    self.address_hash.select { |k,v| ADDRESS_FIELDS_ALL.include?(k) }
    self.address_hash.each do |k, v|
      self.address_hash[k] = String(v)
    end
  end 

	after_validation :geocode


  # Methods
  # -----------

  # point1 and point2 are arrays [lat, long]
  def calc_distance(point1, point2)
    # distance in miles
    distance = Geocoder::Calculations.bearing_between(point1[0], point1[1], point2[0], point2[1])
    return distance
  end

  # current_location is a Location object, radius is in miles
  def within_distance?(clat, clong, lat, long, distance)
    calc_dist = calc_distance([clat, clong], [lat, long])
    return calc_dist < distance
  end

  #returns the coordinates of the location you're searching for
  def self.get_coordinates(pars)
    coords = Geocoder.coordinates("#{pars[:address_hash][:street]} #{pars[:address_hash][:city]} #{pars[:address_hash][:zip]} #{pars[:address_hash][:state]}")
    return coords
  end

  def update_locations(locations)

    if locations != nil
      self.address_hash.clear()
      self.address_hash.merge(locations)

      self.save
    end
  end

  def include_location?(location)
    self.address_hash.include?(location)
  end
  


  def include_location_or_empty?(location)
    self.include_location?(location) || self.address_hash.empty?
  end


 
end