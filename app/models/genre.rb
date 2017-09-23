class Genre < ApplicationRecord
  validates :name, uniqueness: true
end
