class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, :price, :location, presence: true
  validates :description, length: { minimum: 30 }
  validates :price, numericality: { greater_than: 0 }
end
