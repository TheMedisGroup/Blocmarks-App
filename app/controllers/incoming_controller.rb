class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "hello there"
    puts params[:sender]
    puts "testing 2 "
    users = User.where(email: params[:sender])
    puts "hello there 3"
    if users.count == 0
      puts "hello there 4"
      User.invite!(email: params[:sender], name: params[:sender])
      puts "hello there 5"
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
