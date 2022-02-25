class Offer < ApplicationRecord
  geocoded_by :address

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  validates :title, :price, :address, :photo, presence: true, allow_nil: false
  validates :description, length: { minimum: 30 }
  validates :price, numericality: { greater_than: 0 }

  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_title, against: [ :title ],
                  associated_against: { user: [:side]},
                  using: { tsearch: { prefix: true } }

  def purchased?(user)
    self.bookings.each do |booking|
      return true if booking.user_id == user.id
    end
    return false
  end

  def my_offer?(user)
    user == self.user
  end
end
