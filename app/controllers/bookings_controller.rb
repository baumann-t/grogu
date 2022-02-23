class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update]

  def show; end

  def new
    @booking = Booking.new
    @offer = Offer.where(id: params[:offer_id]).first
  end

  def create
    @booking = Booking.new(booking_params)
    @offer = Offer.where(id: params[:offer_id]).first
    @booking.offer = @offer
    @booking.user = current_user

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render 'bookings/new'
    end
  end

  def user_bookings
    @user_bookings = Booking.where(user_id: current_user.id)
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: "The booking was confirmed successfully. May the Force be with you."
    else
      render :edit
    end
  end

  def offer_bookings
    @offer = Offer.where(id: params[:offer_id]).first
    @bookings = Booking.where(offer_id: params[:offer_id])
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:user_message, :start_date, :end_date, :confirmed)
  end
end
