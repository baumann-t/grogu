class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @offer = Offer.where(id: params[:offer_id]).first
    @review.offer = @offer
    if @review.save
      redirect_to offer_reviews_path([@offer])
    else
      render 'offer/show'
    end
  end

  def index
    @all_reviews = Review.where(offer_id: params[:offer_id])
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end
end
