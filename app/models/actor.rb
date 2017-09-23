class Actor < ApplicationRecord
  # Actor: actor_label should be unique
  validates :actor_label, uniqueness: true
end
