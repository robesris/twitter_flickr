class FlickrImage

  attr_accessor :hashtag, :photo_info, :flickr_page_url, :thumbnail_url

  def initialize(photo, hashtag)
    begin # ignore api errors - just get back the photos we can
      self.hashtag = hashtag
      self.photo_info = flickr.photos.getInfo(photo_id: photo.id, secret: photo.secret)
      self.flickr_page_url = self.photo_info.urls.first._content
      photo_sizes = flickr.photos.getSizes(photo_id: photo["id"])
      self.thumbnail_url = photo_sizes.select{ |photo_size| photo_size["label"] == "Large Square" }.first["source"]
    rescue => e
      puts e.backtrace.join("\n")
    end
  end
end