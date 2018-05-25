class ReviewsController < ApplicationController

  def index
    # Note: this route is included since Reviews#create may render 'products/show'
    # but with address bar pointing to /products/:id/reviews from the failed POST.
    # If user refreshes page, it will GET to this index method
    # This is probably not ideal handling but needs to be implemented due to time.
    @product = Product.find(params[:product_id])
    redirect_to @product
  end
  
  def create
    # Create the review associated with the product
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)

    # Assign user id to the review
    @review.user = current_user

    if @review.save
      flash[:success] = "Review successfully saved!"
      redirect_to @product
    else
      flash.now[:danger] = "There was an error saving your review. Please try again"
      render "products/show"
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