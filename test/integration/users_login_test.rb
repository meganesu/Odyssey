require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	# Automatically runs before tests
	def setup
		# Set user to :megan (defined in fixtures/users.yml)
		@user = users(:megan)
	end

	test "login with invalid information" do
		get login_path
		assert_template 'sessions/new'
		post login_path, session: { email: "", password: "" }
		assert_template 'sessions/new'
		# Show error message
		assert_not flash.empty?
		# Error message should disappear when page refreshes/changes
		get root_path
		assert flash.empty?
	end

	test "login with valid information followed by logout" do
		get login_path
		post login_path, session: { email: @user.email, password: 'password' }
		assert is_logged_in?
		assert_redirected_to @user # Check for correct redirect target
		follow_redirect! # Follow to actually visit redirect target page
		assert_template 'users/show' # User homepage
		assert_select "a[href=?]", login_path, count: 0 # Login link disappears
		assert_select "a[href=?]", logout_path # Logout link appears
		assert_select "a[href=?]", user_path(@user) # Link to user homepage appears
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_select "a[href=?]", login_path # Login link appears in navbar
		assert_select "a[href=?]", logout_path, count: 0 # Logout link disappears
		assert_select "a[href=?]", user_path(@user), count: 0 # Link to user page disappears

		# Simulate a user clicking logout in a second browser window
		# (ex. user was using both Firefox and Chrome, logged out on one, then the other)
		delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path # Login link appears in navbar
		assert_select "a[href=?]", logout_path, count: 0 # Logout link disappears
		assert_select "a[href=?]", user_path(@user), count: 0 # Link to user page disappears
	end	

	test "login with remembering" do
		log_in_as(@user, remember_me: '1')
		assert_not_nil cookies['remember_token'] # cookies can't use symbol keys within tests
	end

	test "login without remembering" do
		log_in_as(@user, remember_me: '0')
		assert_nil cookies['remember_token']
	end
	
end
