class VideosController < ApplicationController
  before_action :validate_search_key, only: [:index, :search]
  def index
    @videos = Video.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    if @query_string.present?
      @videos = search_params
    end
  end

protected
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  def search_params
    Video.ransack({:video_id_cont => @query_string}).result(distinct: true)
  end
end
