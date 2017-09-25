class ActorsController < ApplicationController
  def index
    @actors = Actor.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @actor = Actor.find(params[:id])
  end
end
