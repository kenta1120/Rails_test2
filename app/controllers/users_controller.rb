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
    @user = current_user
    if @user.update(params.require(:user).permit(:avatar, :name, :introduction))
      redirect_to user_path(@user), notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  def destroy
  end
end
