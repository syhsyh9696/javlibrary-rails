class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def videos
    @user = current_user
    @videos = @user.videos
  end
end
