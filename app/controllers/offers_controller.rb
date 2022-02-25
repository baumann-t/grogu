class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @offers = params[:query].present? ? Offer.search_by_title(params[:query]) : Offer.all
    @markers = create_markers(@offers)
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

    @offer.mapping

    if @offer.save
      redirect_to offer_path(@offer)
    else
      render 'offers/new'
    end
  end

  def edit; end

  def update
    if @offer.update(offer_params)
      redirect_to offer_path(@offer)
    else
      render :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_to my_offers_path
  end

  private

  def create_markers(offers)
    offers.geocoded.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "info_window", locals: { offer: offer })
      }
    end
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :price, :location, :description, :photo, :address)
  end
end
