class Troop < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :events
  belongs_to :address, dependent: :destroy

  enum state: [:pending, :active, :inactive]
end
