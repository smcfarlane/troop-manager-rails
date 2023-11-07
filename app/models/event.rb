class Event < ApplicationRecord
  belongs_to :user
  belongs_to :troop
  belongs_to :address, dependent: :destroy
  has_many :messages, dependent: :destroy
end
