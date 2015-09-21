class Location < ActiveRecord::Base
	belongs_to :trip
	has_many :activities

	validates :trip_id, presence: true
	validates :name, presence: true, length: { maximum: 60 }
	validates :arrival, presence: true
	validates :departure, presence: true

end
