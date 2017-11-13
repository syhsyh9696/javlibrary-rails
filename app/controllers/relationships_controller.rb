class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @actor = Actor.find(params[:actor_id])
    current_user.follow(@actor.id)
    redirect_to @actor
  end

  def destroy
    @actor = Actor.find(params[:actor_id])
    current_user.unfollow(@actor.id)
    redirect_to @actor
  end
end
