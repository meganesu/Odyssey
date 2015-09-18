class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# If email corresponds to user in db && password is correct for that user
  		# Log the user in and redirect to user's show page
  		log_in user # method in SessionsHelper
  		# If :remember_me checked, save cookies for user, else forget cookies
  		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_to user
  	else
  		# Create an error message.
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end

end
