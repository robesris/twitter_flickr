class FlickrClient
  TF_FLICKR_ACCESS_TOKEN=ENV['TF_FLICKR_ACCESS_TOKEN']
  TF_FLICKR_SECRET=ENV['TF_FLICKR_SECRET']

  attr_accessor :limit, :hashtags, :image_sets

  def initialize(limit, hashtags)
    limit = limit.to_i
    limit = 1 if limit < 1
    self.limit = limit or 1
    self.hashtags = hashtags
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

  def construct_hashtag_image_sets
    self.image_sets = self.hashtags.map do |hashtag|
      self.tagged_images(hashtag)
    end
    self.image_sets.reject!{ |image_set| image_set.empty? }
    self.image_sets.sort!{ |set1, set2| set1.first.hashtag.downcase <=> set2.first.hashtag.downcase }
    self.image_sets
  end

  def no_images?
    self.image_sets.empty?
  end

  def no_hashtags?
    self.hashtags.empty?
  end
end