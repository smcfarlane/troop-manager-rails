class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :troop

  enum role: [:leader, :scout_parent]

  scope :current, -> { where(current: true) }
  scope :all_details, -> {
    joins(:user, :troop).select('memberships.*, users.name as user_name, users.email as user_email, troops.name as troop_name, troops.number as troop_number')
  }

  def self.role_options
    self.roles.map { |k, _| [k.titlecase, k] }.reverse
  end

  def troop_name
    return self[:troop_name] if self[:troop_name].present?
    self.troop.name
  end

  def troop_number
    return self[:troop_number] if self[:troop_number].present?
    self.troop.number
  end

  def user_name
    return self[:user_name] if self[:user_name].present?
    self.user.name
  end

  def user_email
    return self[:user_email] if self[:user_email].present?
    self.user.email
  end
end
