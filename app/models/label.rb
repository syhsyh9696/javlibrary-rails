class Label < ApplicationRecord
  validates :video_label, uniqueness: true
end
