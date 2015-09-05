class Location < ActiveRecord::Base
	belongs_to :trip
	has_many :activities
end
