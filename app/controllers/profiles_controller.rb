class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:avatar, :name, :introduction))
      redirect_to edit_profile_path
    else
      render :edit
    end
  end
end
