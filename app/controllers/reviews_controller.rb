class ReviewsController < ApplicationController

  def create
    # Create the review associated with the product
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)

    # Assign user id to the review
    @review.user_id = session[:user_id]

    if @review.save
      redirect_to :product, notice: 'Review saved!'
    else
      render :product
    end
  end

  private

  def review_params
    # TODO: does not check for product_id... not sure if necessary since
    # included in the view's form
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end
