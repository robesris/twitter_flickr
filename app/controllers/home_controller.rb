class HomeController < ApplicationController
  def index
    @tweets ||= []
  end

  def search
    client = TwitterClient.new
    @hashtags = client.recent_hashtags(params[:twitter_handle])

    render action: :index
  end


end
