class ActorsController < ApplicationController
  def index
    @actors = Actor.paginate(:page => params[:page], :per_page => 30)

    @q = Actor.ransack(params[:q])
    @actor = @q.result(distinct: true)
  end

  def show
    @actor = Actor.find(params[:id])
  end

  def output
    @actor = Actor.find(params[:id])
    render :json => @actor.videos_dataset
  end

  def genres
    @actor = Actor.find(params[:id])
    render :json => @actor.genres_dataset
  end
end
