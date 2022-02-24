class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @offer = Offer.where(id: params[:offer_id]).first
    @review.offer = @offer
    if @review.save
      redirect_to offer_path(@offer)
    else
      render 'offer/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end
end
