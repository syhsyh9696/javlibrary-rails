class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :actors, -> { distinct }

  def follow(other_actor)
    self.actors << other_actor unless self.actors.include?(other_actor)
  end

  def unfollow(other_actor)
    self.actors.find(other_actor).destroy if self.actors.include?(other_actor)
  end

  def following?(other_actor)
    self.actors.include?(other_actor)
  end
end
