class TwitterClient
  TF_TWITTER_CONSUMER_KEY=ENV['TF_TWITTER_CONSUMER_KEY']
  TF_TWITTER_CONSUMER_SECRET=ENV['TF_TWITTER_CONSUMER_SECRET']
  TF_TWITTER_ACCESS_TOKEN=ENV['TF_TWITTER_ACCESS_TOKEN']
  TF_TWITTER_SECRET=ENV['TF_TWITTER_SECRET']

  TF_FLICKR_ACCESS_TOKEN=ENV['TF_FLICKR_ACCESS_TOKEN']
  TF_FLICKR_SECRET=ENV['TF_FLICKR_SECRET']

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TF_TWITTER_CONSUMER_KEY
      config.consumer_secret     = TF_TWITTER_CONSUMER_SECRET
      config.access_token        = TF_TWITTER_ACCESS_TOKEN
      config.access_token_secret = TF_TWITTER_SECRET
    end
  end

  def tweets(twitter_handle)
    @client.user_timeline(twitter_handle)
  end
end