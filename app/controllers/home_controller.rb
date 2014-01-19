class HomeController < ApplicationController
  def index
    @tweets ||= []
  end

  def search
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TF_TWITTER_CONSUMER_KEY
      config.consumer_secret     = TF_TWITTER_CONSUMER_SECRET
      config.access_token        = TF_TWITTER_ACCESS_TOKEN
      config.access_token_secret = TF_TWITTER_SECRET
    end
    @tweets = client.user_timeline(params[:twitter_handle])

    render action: :index
  end


end
