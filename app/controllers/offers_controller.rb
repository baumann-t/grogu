class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :my_offers ]
  before_action :set_offer, only: :show

  def show; end

  def my_offers
    @offers = Offer.all
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
