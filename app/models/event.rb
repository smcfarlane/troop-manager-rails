class Event < ApplicationRecord
  belongs_to :user
  belongs_to :troop
  belongs_to :address, dependent: :destroy
end
