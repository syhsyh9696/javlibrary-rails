class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :actors, -> { distinct }
  has_and_belongs_to_many :videos, -> { distinct }


  def follow(actor_id)
    self.actors << Actor.find(actor_id) unless self.actors.include?(Actor.find(actor_id))
  end

  def unfollow(actor_id)
    self.actors.delete(Actor.find(actor_id)) if self.actors.include?(Actor.find(actor_id))
  end

  def following?(other_actor)
    self.actors.include?(other_actor)
  end

  def recent_videos
    now = Time.new; time = now.to_s.split[0][0..-4]

    videos = []
    self.actors.each do |actor|
      actor.videos.each do |video|
        videos << [actor.name, video] if video.release_date[0..-4] == time
      end
    end
    videos
  end

  def recent_videos_without_actors
    now = Time.new; time = now.to_s.split[0][0..-4]

    videos = []
    self.actors.each do |actor|
      actor.videos.each do |video|
        videos << video if video.release_date[0..-4] == time
      end
    end
    videos.uniq
  end

=begin
  def recent_videos_rss
    result = Array.new
    self.recent_videos_without_actors.each do |video|
      origin = Hash.new
      origin.store('ID', video.video_id)
      origin.store('NAME', video.video_name.gsub(video.video_id, '').strip)
      origin.store('RELEASE_DATE', video.release_date)
      origin.store('LENGTH', video.length)
      origin.store('MAKER', video.maker)
    end
    result
  end
=end

  def fave_video(video_id)
    self.videos << Video.find(video_id) unless self.videos.include?(Video.find(video_id))
  end

  def unfave_video(video_id)
    self.videos.delete(Video.find(video_id)) if self.videos.include?(Video.find(video_id))
  end

end
