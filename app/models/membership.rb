class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :troop

  enum role: [:leader, :scout_parent]
end
