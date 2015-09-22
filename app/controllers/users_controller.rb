class UsersController < ApplicationController

  # These methods get called before the corresponding actions execute
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @trips = @user.trips.paginate(page: params[:page])

    # Use for 'Create new trip' form in modal
    @trip = current_user.trips.build if logged_in?
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) # "strong parameters" technique (see private method)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to Odyssey! Click 'New Trip' to get started."
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  	end


    # BEFORE FILTERS

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
