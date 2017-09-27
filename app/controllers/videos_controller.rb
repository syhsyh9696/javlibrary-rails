class VideosController < ApplicationController
  before_action :validate_search_key, only: [:search]
  def index
    @videos = Video.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @video = Video.find(params[:id])
  end

  def search

  end

protected
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end
end
