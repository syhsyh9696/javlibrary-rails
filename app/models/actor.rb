class Actor < ApplicationRecord
  # Actor: actor_label should be unique
  validates :actor_label, uniqueness: true

  has_and_belongs_to_many :videos
  has_and_belongs_to_many :users, -> { distinct }

  def followers
    self.users.size
  end
end
