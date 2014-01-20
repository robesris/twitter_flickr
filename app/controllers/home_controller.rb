class HomeController < ApplicationController
  def index
    @hashtag_image_sets ||= []
  end

  def search
    twitter_client = TwitterClient.new
    hashtags = twitter_client.recent_hashtags(params[:twitter_handle])

    limit = params[:limit].to_i
    limit = 1 if limit < 1

    flash[:notice] = ""
    if hashtags.any?
      flickr_client = FlickrClient.new(limit)
      @hashtag_image_sets = hashtags.map do |hashtag|
        flickr_client.tagged_images(hashtag)
      end
      @hashtag_image_sets.reject!{ |hashtag_image_set| hashtag_image_set.empty? }
      @hashtag_image_sets.sort!{ |set1, set2| set1.first.hashtag.downcase <=> set2.first.hashtag.downcase }
      flash[:notice] = "No images found" if @hashtag_image_sets.empty?
    else
      @hashtag_image_sets = []
      flash[:notice] = "No recent hashtags found"
    end

    render action: :index
  end
end
