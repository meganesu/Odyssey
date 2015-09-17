require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # setup automatically gets run before each test
  def setup
  	# Set up an initially valid User model object
  	#   (since instance var, will be automatically available in all tests)
  	@user = User.new(first_name: "Example", last_name: "User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "first name should be present" do
  	@user.first_name = "     "
  	assert_not @user.valid?
  end

  test "last name should be present" do
  	@user.last_name = "     "
  	assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    # Max first_name length: 30
    @user.first_name = "a" * 31
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    #Max last_name length: 30
    @user.last_name = "a" * 31
    assert_not @user.valid?
  end

  test "email should not be too long" do
    # Max email length: 255 (max length of string)
    #   244 = 256 - "@example.com".length
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    # %w[] creates array of strings
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # Can't have multiple users with the same email address
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    # Min password length: 6
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
