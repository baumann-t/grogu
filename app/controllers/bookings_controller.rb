class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: :show

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


  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:user_message, :start_date, :end_date)
  end

end
