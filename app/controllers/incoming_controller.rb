class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts params
    @user = User.find_by(email: params[:sender]) #Find the user by using params[:sender]
    puts @user
    if @user.nil? || @user.pending_invite?
      User.invite!(email: params[:sender], name: params[:sender])
    else
      puts params[:subject]
      @topic = Topic.find_or_create_by(title: params[:subject])
      puts @topic
      @url = params["stripped-text"]
      puts @url
      @bookmark = Bookmark.new(user: @user, topic: @topic, url: @url)
      puts @bookmark
      authorize @bookmark
      @bookmark.save
    end
    head 200
  end

end
