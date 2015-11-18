class BookmarksController < ApplicationController

  def index
    @topics = Topic.all
    @user = current_user
    @bookmarks = Bookmark.all
  end

  def show
    @topic = Topic.where(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end
  
  def new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      flash[:notice] = "That's what we call a SAVED bookmark."
    else
      flash[:error] = "The bookmark did not save. Try again please."
    end

    redirect_to @topic
  end

  def edit
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
