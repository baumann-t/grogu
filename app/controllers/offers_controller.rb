class OffersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @offers = Offer.search_by_title(params[:query])
    else
      @offers = Offer.all
    end

    @markers = @offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "info_window", locals: { offer: offer })
      }
    end
  end

  def show; end

  def my_offers
    @offers = Offer.where(user_id: current_user.id)
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    @offer.latitude = Geocoder.search(@offer.address).first.latitude
    @offer.longitude = Geocoder.search(@offer.address).first.longitude
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

  def destroy
    @offer.destroy
    redirect_to my_offers_path
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :price, :location, :description, :photo, :address)
  end
end
