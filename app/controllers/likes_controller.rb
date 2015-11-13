class LikesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = "Topic ookmarked."
      redirect_to @bookmark
    else
      flash[:notice] = "Bookmark deleted."
      redirect_to @bookmark
    end
  end
