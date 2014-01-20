class FlickrClient
  TF_FLICKR_ACCESS_TOKEN=ENV['TF_FLICKR_ACCESS_TOKEN']
  TF_FLICKR_SECRET=ENV['TF_FLICKR_SECRET']

  attr_accessor :limit

  def initialize(limit)
    self.limit = limit or 1
    FlickRaw.api_key = TF_FLICKR_ACCESS_TOKEN
    FlickRaw.shared_secret = TF_FLICKR_SECRET
  end

  def tagged_images(tag)
    photo_list = flickr.tags.getClusterPhotos(tag: tag)
    puts "Going through photos..."
    photo_list.first(limit).map do |photo|
      FlickrImage.new(photo, tag)
    end
  end
end