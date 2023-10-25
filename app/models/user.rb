class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable, :argon2

  has_many :memberships, dependent: :destroy
  has_many :troops, through: :memberships
  has_many :events
  has_many :messages, dependent: :destroy
end
