# Primary Author: Michelle Johnson (mchlljy)

# Model to store a location address. Automatically generates latitude and longitude attributes from address.
class Location < ActiveRecord::Base

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

  # Capitalize first letter of each word in name
  before_validation do
    unless name.nil?
      puts "the name: #{name}"
      self.name = self.name.downcase.split.map(&:capitalize).join(' ') 
    end
  end 

  # Methods
  # -----------

  # Distance in miles.
  def calc_distance(latidue, longitude)
    Geocoder::Calculations.distance_between([self.latitude, self.longitude], [latitude, longitude])
  end

  def get_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip_code}"
  end
end