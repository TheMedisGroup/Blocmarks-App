class LikesController < ApplicationController
  before_action :load_bookmark_and_like

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.build(bookmark: @bookmark)
    authorize @like

    if like.save
      flash[:notice] = "Bookmark is totally liked. Well Done."
      redirect_to request_referer
    else
      flash[:error] = "Please Try Again."
      redirect_to :back
    end
  end


  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = Like.find(params[:id])
    authorize @like

    if like.destroy
      flash[:notice] = "Like deleted."
      redirect_to request_referer
    else
      flash[:error] = "Please Try Again."
      redirect_to :back
    end
  end

private
  def load_bookmark_and_like
    @bookmark = Bookmark.find(parmas[:bookmark_id])
    @like = @bookmark.likes.where(user_id: current_user.id).first
  end
end
