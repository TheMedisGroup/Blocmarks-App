class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "hello world"
    @user = User.find(params[:sender]) #Find the user by using params[:sender]
    @topic = Topic.find(params[:subject]) #Find the topic by using params[:subject]
    @url = params["body-plain"]
    #Assign the url to a variable after retrieving it from params["body-plain"]
    if @user.nil?
      @user = User.new(params[:sender])
      @user.save #check if the user is nil, if so , create and save a new user
    else

    end

    if topic.nil? #Check if the topic is nil, if so, create and save a new topic
      @topic = Topic.new(params[:subject])
      @topic.save
    else
      #Now that we're sure we have a valid user and topic, build and save a new bookmark
    end

    Bookmark.new(params[:user, :topic, :url])

    head 200
  end
end
