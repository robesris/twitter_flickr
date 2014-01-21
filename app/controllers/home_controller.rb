class HomeController < ApplicationController
  def index
    @hashtag_image_sets ||= []
  end

  def search
    twitter_client = TwitterClient.new
    hashtags = twitter_client.recent_hashtags(params[:twitter_handle])

    flickr_client = FlickrClient.new(params[:limit], hashtags)
    flickr_client.construct_hashtag_image_sets
    flash[:notice] = "Done."
    flash[:error] = nil
    flash[:error] = "No images found" if flickr_client.no_images?
    flash[:error] = "No recent hashtags found" if flickr_client.no_hashtags?

    @hashtag_image_sets = flickr_client.image_sets

    render action: :index
  end
end
