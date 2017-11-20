class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def videos
    @videos = User.find(current_user.id).videos
  end
end
