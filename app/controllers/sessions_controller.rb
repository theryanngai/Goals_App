class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    
    if @user
      flash.now[:alerts] = "You have successfully logged in!"
      log_in_user!(@user)
    else
      flash.now[:alerts] = ["Invalid Username or Password"]
      @user = User.new
      render :new
    end                                 
  end
  
  def destroy
    log_out!(current_user)
  end
  
  
  private 
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
