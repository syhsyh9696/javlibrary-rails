class Video < ApplicationRecord
  validates :video_id, uniqueness: true
end
