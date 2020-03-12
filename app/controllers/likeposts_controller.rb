class LikepostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    like = current_user.likeposts.create(likepost_params)
    like.save
    redirect_to posts_path
  end

  def destroy
    Likepost.find_by(user_id: current_user.id, post_id: params[:id]).destroy
    redirect_to posts_path
  end

    private
      def likepost_params
        params.permit(:post_id)
      end
end
