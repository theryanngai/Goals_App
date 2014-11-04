class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash.now[:alerts] = 'Thanks for signing up!'
      log_in_user!(@user)
    else
      flash.now[:alerts] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = current_user
    render :show
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
