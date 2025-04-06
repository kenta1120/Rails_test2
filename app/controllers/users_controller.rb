class UsersController < ApplicationController
  def index
    @users = User.all
    @rooms = Room.all
  end

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(params.require(:user).permit(:avatar, :name, :introduction))
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
  end
end
