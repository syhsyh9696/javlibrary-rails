class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def videos
    @user = current_user
    @videos = @user.videos
  end

  def feed
    @user = User.find(params[:id])
    @videos = @user.recent_videos_without_actors
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end

  end
end
