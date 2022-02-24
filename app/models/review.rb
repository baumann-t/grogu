class Review < ApplicationRecord
  belongs_to :offer
  delegate :user, to: :offer
end
