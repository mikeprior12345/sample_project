class ReviewsController < ApplicationController
  

  def index
# For URL like /itemtests/1/reviews
# # Get the itemtest with id=1
 @itemtest = Itemtest.find(params[:itemtest_id])
# # Access all reviews for that itemtest
 @reviews = @itemtest.reviews
  end

  def show
  @itemtest = Itemtest.find(params[:itemtest_id])
# For URL like /itemtests/1/reviews/2
# # Find an review in itemtests 1 that has id=2
  @review = @itemtest.reviews.find(params[:id])
#
  end

  def new
  @itemtest = Itemtest.find(params[:itemtest_id])
  #
  # Associate an review object with itemtest 1
  #
  @review = @itemtest.reviews.build
  end

  def edit
  @itemtest = Itemtest.find(params[:itemtest_id])
# For URL like /itemtests/1/reviews/2/edit
# # Get review id=2 for itemtest 1
 @review = @itemtest.reviews.find(params[:id])
#
  end
def update
@itemtest = Itemtest.find(params[:itemtest_id])
@review = Review.find(params[:id])
if @review.update(params.require(:review).permit(:details))
# Save the review successfully
 redirect_to itemtest_review_url(@itemtest, @review)
 else
 render :action => "edit"
 end
 end
#
def destroy
@itemtest = Itemtest.find(params[:itemtest_id])
@review = Review.find(params[:id])
@review.destroy
respond_to do |format|
format.html { redirect_to itemtest_reviews_path(@itemtest) }
format.xml { head :ok }
end
end

def create
@itemtest = Itemtest.find(params[:itemtest_id])
# For URL like /itemtests/1/reviews
# # Populate an review associate with itemtest 1 with form data
# # itemtest will be associated with the review
 @review = @itemtest.reviews.build(params.require(:review).permit(:details))
 if @review.save
 # Save the review successfully
 redirect_to itemtest_review_url(@itemtest, @review)
 else
 render :action => "new"
 end
 end
#
  
end
