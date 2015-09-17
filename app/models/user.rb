class User < ActiveRecord::Base
	# Ignore capitalization of email (according to user input)
	before_save { self.email = email.downcase }

	validates :first_name, presence: true, length: { maximum: 30 }
	validates :last_name, presence: true, length: { maximum: 30 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	has_secure_password # enforces validations on virtual password, password_confirmation attr
	validates :password, presence: true, length: { minimum: 6 }

	has_many :trips
end
