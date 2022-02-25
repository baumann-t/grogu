class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :offers, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :offers
  has_one_attached :photo

  validates :username, presence: true
end
