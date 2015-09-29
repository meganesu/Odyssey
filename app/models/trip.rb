class Trip < ActiveRecord::Base
	belongs_to :user
	has_many :locations, dependent: :destroy

  # Sort so that newest trips are shown first
	default_scope -> { order(created_at: :desc) }

	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 60 }
	validates :start_loc, presence: true
	validates :end_loc, presence: true

end