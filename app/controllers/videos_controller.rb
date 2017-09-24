class VideosController < ApplicationController
  def index
    @videos = Video.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @video = Video.find(params[:id])
    p @video
  end
end
