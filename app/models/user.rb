class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable, :argon2

  has_many :memberships, dependent: :destroy
  has_many :troops, through: :memberships do
    def current
      where(memberships: { current: true }).first
    end
  end
  has_many :events
  has_many :messages, dependent: :destroy

  scope :admins, -> { where(admin: true) }
  scope :with_current_troop, -> {
    joins_sql = <<-SQL
      LEFT JOIN memberships ON memberships.user_id = users.id AND memberships.current = true
      LEFT JOIN troops ON troops.id = memberships.troop_id
    SQL
    joins(joins_sql).select("users.*, troops.name as troop_name, troops.number as troop_number")
  }
end
