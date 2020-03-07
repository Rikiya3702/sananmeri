class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    if current_user.id == user.id
      user.destroy
    end
    redirect_to "/users"
  end
end
