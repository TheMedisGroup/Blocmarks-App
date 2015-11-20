class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    authorize @topic
    @bookmarks = @topic.bookmarks.includes(:user).includes(:likes)
  end

  def new
    @topic = Topic.new
    @topic.user = current_user
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated successfully."
      redirect_to topics_path
    else
      flash[:error] = "Topic was not updated. Please try again."
      redirect_to topics_path
    end
  end

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

  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end
