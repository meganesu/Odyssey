class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) # "strong parameters" technique (see private method)
  	if @user.save
  		flash[:success] = "Welcome to Odyssey! Click 'New Trip' to get started."
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  	end

end
