class FlickrClient
  TF_FLICKR_ACCESS_TOKEN=ENV['TF_FLICKR_ACCESS_TOKEN']
  TF_FLICKR_SECRET=ENV['TF_FLICKR_SECRET']

  attr_accessor :limit

  def initialize(limit)
    self.limit = limit or 1
    FlickRaw.api_key = TF_FLICKR_ACCESS_TOKEN
    FlickRaw.shared_secret = TF_FLICKR_SECRET
  end

  def tagged_image_urls(tag)
    photo_list = flickr.tags.getClusterPhotos(tag: tag)
    puts "Going through photos..."
    urls = photo_list.first(limit).map do |photo|
      begin # ignore api errors - just get back the photos we can
        photo_sizes = flickr.photos.getSizes(photo_id: photo["id"])
        photo_sizes.select{ |photo_size| photo_size["label"] == "Large Square" }.first["source"]
      rescue => e
        puts e.backtrace.join("\n")
      end
    end
  end
end