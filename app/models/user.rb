class User < ActiveRecord::Base

	has_many :trips, dependent: :destroy

	# Used to remember user information even after reopening browser
	attr_accessor :remember_token

	# Ignore capitalization of email (according to user input)
	before_save { self.email = email.downcase }

	# Validate name
	validates :first_name, presence: true, length: { maximum: 30 }
	validates :last_name, presence: true, length: { maximum: 30 }

	# Validate email
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	# Validate password
	has_secure_password # enforces validations on virtual password, password_confirmation attr
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


	# CLASS METHODS

	# Returns the hash digest of the given string. (Use to hash password strings for fixtures)
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Defines a proto-feed.
	# See "Following Users" for full implementation. (Hartl Rails Tutorial, CH 12)
	def feed
		Trip.where("user_id = ?", id)
	end

end
