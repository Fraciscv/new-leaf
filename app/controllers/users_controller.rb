class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create]

  def home

  end

  def show
    #find_user
    render :show
  end

  def edit
    #find_user
    render :edit
  end

  def new
    @user = User.new
    @error = flash[:error]
    render :new
  end
    
  def create
    @user = User.create(user_params)
      if @user.valid?
        login_user(@user)
        redirect_to home_path

      else 
        flash[:error]= @user.errors.full_messages
        redirect_to new_user_path
    end
  end

  def update

  end

  def destroy
    @user.destroy
    redirect_to :new_user_path
  end
  
  private
    
  def user_params
    params.require(:user).permit(:username, :password, :email, :avatar, gardens_attributes:[:garden_name] )
  end
  
  def find_user
   @user = User.find(params[:id])
  end

end