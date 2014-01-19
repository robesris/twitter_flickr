class HomeController < ApplicationController
  def index
    @tweets ||= []
  end

  def search
    client = TwitterClient.new
    @tweets = client.tweets(params[:twitter_handle])

    render action: :index
  end


end
