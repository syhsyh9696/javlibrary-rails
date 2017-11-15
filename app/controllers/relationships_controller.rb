class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @actor = Actor.find(params[:actor_id])
    current_user.follow(@actor.id)
    respond_to do |format|
      format.html { redirect_to @actor }
      format.js
    end
  end

  def destroy
    @actor = Actor.find(params[:actor_id])
    current_user.unfollow(@actor.id)
    respond_to do |format|
      format.html { redirect_to @actor }
      format.js
    end
  end
end
