class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # validates :title, :price, :location, presence: true
  validates :title, :price, :address, presence: true
  validates :description, length: { minimum: 30 }
  validates :price, numericality: { greater_than: 0 }
end
