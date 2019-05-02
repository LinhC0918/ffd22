class CommentsController < ApplicationController
  before_action :load_comment, only: %i(edit update destroy)
  before_action :load_comment_product, only: %i(update destroy)
  before_action :logged_in_user, only: :create

  def create
    @comment = Comment.new comment_params
    load_comment_product
    @product_id = @comment.product_id
    @comment.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = t ".delete_failed"
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :rating, :user_id, :product_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".comment_not_found"
    redirect_to product_path
  end

  def load_comment_product
    @comment_product = Comment.includes(:product).find_comments(@comment)
                              .order_comments
  end
end
