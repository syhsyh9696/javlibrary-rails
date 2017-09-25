class StarsController < ApplicationController
  def index
    @stars = Star.all
  end

  def show
    @star = Star.find(params[:id])
  end
end
