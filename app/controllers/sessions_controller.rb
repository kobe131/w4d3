class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
   
  def create 
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    # debugger
    if @user 
  
      login(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end 
  
  def destroy 
    logout
    # params, session, and flash(use for error) three things 
  end 
  
  
  
  
  
  
  
  
end 