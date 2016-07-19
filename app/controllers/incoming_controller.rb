class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts params[:sender]
    users = User.where(email: params[:sender])
    if users.count == 0
      User.invite!(email: params[:sender], name: params[:sender])
    else
      @user = users.first
      puts params[:subject]
      @topic = Topic.find_or_create_by(title: params[:subject], user: @user)
      puts @topic
      @url = params["stripped-text"]
      puts @url
      @bookmark = Bookmark.new(user: @user, topic: @topic, url: @url)
      puts @bookmark
      # authorize @bookmark
      @bookmark.save
    end
    head 200
  end

end
