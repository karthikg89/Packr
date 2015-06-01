class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(valid_params)
    
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Packr!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def valid_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
