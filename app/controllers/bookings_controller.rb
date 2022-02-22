class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_booking, only: :show

  def show; end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

end
