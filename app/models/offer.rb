class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :title, :price, :location, presence: true
  validates :description, length: { minimum: 30 }
  validates :price, numericality: { greater_than: 0 }
end
