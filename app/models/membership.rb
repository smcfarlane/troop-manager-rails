class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :troop

  enum role: [:leader, :scout_parent]

  scope :current, -> { where(current: true) }
  scope :all_details, -> {
    joins(:user, :troop).select('memberships.*, users.name as user_name, users.email as user_email, troops.name as troop_name, troops.number as troop_number')
  }
end
