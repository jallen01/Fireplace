class Location < ActiveRecord::Base
	belongs_to :user

	has_many :tag_locations
	has_many :tags, :through => :tag_locations

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

	def address
		[self.street, self.city, self.state, self.country].compact.join(", ")
	end
end