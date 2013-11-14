class Location < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

	def address
		[self.street, self.city, self.state, self.country].compact.join(", ")
	end
end
