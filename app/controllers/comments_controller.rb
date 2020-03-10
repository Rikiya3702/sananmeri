class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to posts_path
  end

  private

    def comment_params
      params.require(:post).permit( :content, :post_id)
    end

    def correct_user
      comment = Comment.find(params[:id])
      if comment.user_id != current_user.id
        redirect_to '/posts'
      end
    end

end
