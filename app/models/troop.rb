class Troop < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships do
    def leaders
      where(memberships: { role: :leader })
    end
  end
  has_many :events
  belongs_to :address, dependent: :destroy

  enum state: [:pending, :active, :inactive]

  accepts_nested_attributes_for :address

  validates :name, :number, presence: true
end
