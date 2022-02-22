class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_offer, only: :show

  def show; end

  def new
    @offer = Offer.new
  end

  def create
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :price, :location, :description)
  end
end
