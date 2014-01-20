class HomeController < ApplicationController
  def index
    @hashtag_images ||= []
  end

  def search
    twitter_client = TwitterClient.new
    hashtags = twitter_client.recent_hashtags(params[:twitter_handle])

    limit = params[:limit].to_i
    limit = 1 if limit < 1

    flickr_client = FlickrClient.new(limit)
    @hashtag_images = hashtags.map do |hashtag|
      { hashtag: hashtag, image_urls: flickr_client.tagged_image_urls(hashtag) }
    end
    @hashtag_images.sort!{ |img1, img2| img1[:hashtag].downcase <=> img2[:hashtag].downcase }

    render action: :index
  end
end
