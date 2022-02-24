class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_title,
    against: [ :title ],
    associated_against: {
      user: [ :side ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  # validates :title, :price, :location, presence: true
  validates :title, :price, :address, presence: true
  validates :description, length: { minimum: 30 }
  validates :price, numericality: { greater_than: 0 }
end
