class Video < ApplicationRecord
  validates :video_id, uniqueness: true

  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors

  has_and_belongs_to_many :users, -> { distinct }


  def actors_string
    result = String.new
    self.actors.each do |actor|
      result << actor.name << " "
    end

    result.strip
  end

end
