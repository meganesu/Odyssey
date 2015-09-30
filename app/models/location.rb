class Location < ActiveRecord::Base
	belongs_to :trip
	has_many :activities, dependent: :destroy

	geocoded_by :name
	# Avoid unnecessary API requests: only geocode object if loc name is present,
		#   has been changed since last save, or has never been saved
	after_validation :geocode, if: ->(obj){ obj.name.present? and obj.name_changed? }
	after_validation :lat_changed?

	validates :trip_id, presence: true
	validates :name, presence: true, length: { maximum: 60 }
	validates :arrival, presence: true
	validates :departure, presence: true

	private

		# Use to validate whether geocode was successful (location was valid)
		def lat_changed?
			if (self.name_changed? && !(self.latitude_changed?))
				# If name has changed but latitude didn't, geocoder didn't get returned lat/lng
				self.errors.add(:name, "\'#{self.name}\' is not a valid location")
				return false
			end
			return true
		end

end
