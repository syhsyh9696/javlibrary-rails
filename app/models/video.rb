class Video < ApplicationRecord
  validates :video_id, uniqueness: true

  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors
end
