require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:megan)
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user: { name: "",
  																	email: "invalid",
  																	password: "pass",
  																	password_confirmation: "word" }
  	assert_template 'users/edit'
  end

  test "successful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	first_name = "Foo"
  	last_name = "Bar"
  	email = "foo@bar.com"
  	patch user_path(@user), user: { first_name: first_name,
  																	last_name: last_name,
  																	email: email,
  																	password: "",
  																	password_confirmation: "" }
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal first_name, @user.first_name
  	assert_equal last_name, @user.last_name
  	assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
  	get edit_user_path(@user)
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	first_name = "Foo"
  	last_name = "Bar"
  	email = "foo@bar.com"
  	patch user_path(@user), user: { first_name: first_name,
  																	last_name: last_name,
  																	email: email,
  																	password: "",
  																	password_confirmation: "" }
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal first_name, @user.first_name
  	assert_equal last_name, @user.last_name
  	assert_equal email, @user.email
  end

end
