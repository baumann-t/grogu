class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
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
  validates :title, :price, :address, presence: true, allow_nil: false
  validates :description, length: { minimum: 30 }
  validates :price, numericality: { greater_than: 0 }


  def purchased?(user)
    all_bookings = self.bookings
    has_booked = false
    all_bookings.each do |booking|
      if booking.user_id == user.id
        has_booked = true
      end
    end
    return has_booked
  end

  def my_offer?(user)
    user == self.user
  end
end
