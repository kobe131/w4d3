class UsersController < ApplicationController 
  
  def new 
    @user = User.new 
    render :new 
  end 

  def create 
    @user = User.new(users_params)
    if @user.save
      @current_user = @user 
      login 
      redirect_to cats_url
    else 
      flash[:errors] = @user.errors.full_messages 
      redirect_to new_user_url 
    end
  end
  
  def users_params
    params.require(:user).permit(:user_name, :password)
  end  


end 