class Address < ApplicationRecord
  has_one :troop
  has_one :event

  validates :address_text, presence: true
end
