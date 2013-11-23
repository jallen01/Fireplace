# Primary Author: Michelle Johnson (mchlljy)

# Model to store a location address. Automatically generates latitude and longitude attributes from address.
class Location < ActiveRecord::Base

  # Constants
  # ---------

  # All allowed address fields
  # ADDRESS_FIELDS_ALL = [:street, :city, :state, :country]

  # # Address fields shown in address string
  # ADDRESS_FIELDS_SHOW = [:street, :city, :state, :country]

  # NAME_MAX_LENGTH = 10


  # Attributes
  # ----------

	belongs_to :user

	has_many :tag_locations
	has_many :tags, through: :tag_locations

  # serialize :address_hash, class_name: Hash

  # # Initialize serialized object
  # after_initialize do
  #   if self.address_hash.blank?
  #     self.address_hash = Hash.new
  #   end
  # end

	# geocoded_by :address

  # Returns string representation of address_data. Includes all fields with keys in ADDRESS_FIELDS_SHOW that aren't nil.
  # def address
  #   ADDRESS_FIELDS_SHOW.map { |key| self.address_hash[key] }.compact.join(", ")
  # end


  # Validations
  # -----------

  # validates :user, presence: true

  # validates :name, presence: true, length: { maximum: Location::NAME_MAX_LENGTH }, uniqueness: { scope: :user }

  # Capitalize first letter of each word in name
  before_validation do 
    self.name = self.name.downcase.split.map(&:capitalize).join(' ') 

    # # Sanitize address hash
    # self.address_hash.permit(*ADDRESS_FIELDS_ALL)
    # self.address_hash.each do |k, v|
    #   self.address_hash[k] = String(v)
    # end
  end 

	# after_validation :geocode, if: :address_changed?

  def self.new_location(params)
    params = location_params(params)
    query_str = "#{params[:street]} #{params[:city]} #{params[:state]} #{params[:zip]}"
    coords = Geocoder.search(query_str)[0].coordinates #array [lat, lng]
    location = Location.new({:name => params[:name], :latitude => coords[0], :longitude => coords[1]}) 
    return location
  end

  def get_location_from_db(current_user_id, name)
    loc = Location.find_by(:user_id => current_user_id, :name => name)
    lat = loc.latitude
    lng = loc.longitude
    return [lat, lng]
  end

  def calc_distance(point1, point2) #point1 and point2 are arrays [lat, long]
    distance = Geocoder::Calculations.bearing_between(point1[0], point1[1], point2[0], point2[1]) #distance in miles
    return distance
  end

  def within_distance?(clat, clong, lat, long, distance) #current_location is a Location object, radius is in miles
    calc_dist = calc_distance([clat, clong], [lat, long])
    if calc_dist < distance
      return true
    else
      return false
    end
  end
  
  def self.save_current_location(current_user_id, lat, lng)
    if Location.find_by(:user_id => current_user_id, :name => "Current") == nil
      location = Location.new(:user_id => current_user_id, :name => "Current", :latitude => lat, :longitude => lng)
      location.save
    else
      location = Location.find_by(:name => "Current")
      location.latitude = lat
      location.longitude = lng
      location.save

    end

  end

  private

    def self.location_params(params) #only allow these params (white list)
        params.permit(:name, :street, :city, :state, :zip)
    end
end