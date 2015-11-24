class BookmarksController < ApplicationController

  def index
    @topics = Topic.all
    @user = current_user
    @bookmarks = Bookmark.all
  end

  def show

    def destroy
      @topic = Topic.find(params[:id])
      title = @topic.title
      authorize @topic

      if @topic.destroy
        flash[:notice] = "\"#{title}\" was successfully deleted."
        redirect_to topics_path
      else
        flash[:error] = "There was an error when deleting your topic."
        reder :show
      end
    end
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

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "bookmark was successfully deleted."
      redirect_to topics_path
    else
      flash[:error] = "There was an error when deleting your bookmark."
      reder :show
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
