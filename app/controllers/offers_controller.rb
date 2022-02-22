class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :my_offers ]
  before_action :set_offer, only: [:show, :edit, :update]

  def index
    @offers = Offer.all
  end

  def show; end

  def my_offers
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render 'offers/new'
    end
  end

  def edit; end

  def update
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render :edit
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :price, :location, :description, :photo)
  end
end
