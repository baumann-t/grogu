class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_offer, only: :show

  def show; end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
