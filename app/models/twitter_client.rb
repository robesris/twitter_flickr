class TwitterClient
  TF_TWITTER_CONSUMER_KEY=ENV['TF_TWITTER_CONSUMER_KEY']
  TF_TWITTER_CONSUMER_SECRET=ENV['TF_TWITTER_CONSUMER_SECRET']
  TF_TWITTER_ACCESS_TOKEN=ENV['TF_TWITTER_ACCESS_TOKEN']
  TF_TWITTER_SECRET=ENV['TF_TWITTER_SECRET']

  TF_FLICKR_ACCESS_TOKEN=ENV['TF_FLICKR_ACCESS_TOKEN']
  TF_FLICKR_SECRET=ENV['TF_FLICKR_SECRET']

  attr_accessor :tweets

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TF_TWITTER_CONSUMER_KEY
      config.consumer_secret     = TF_TWITTER_CONSUMER_SECRET
      config.access_token        = TF_TWITTER_ACCESS_TOKEN
      config.access_token_secret = TF_TWITTER_SECRET
    end
  end

  def find_tweets(twitter_handle)
    self.tweets = @client.user_timeline(twitter_handle)
    self.tweets
  end

  def recent_hashtags(twitter_handle)
    find_tweets(twitter_handle) unless tweets
    matches = tweets.map{ |tweet| tweet.text.scan(hashtag_regex) }
    matches.flatten
  end


  private  

  def hashtag_regex
    /#[^\d#][\w-]*/
  end
end