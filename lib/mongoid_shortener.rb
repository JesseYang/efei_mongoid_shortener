require "mongoid_shortener/engine"

module MongoidShortener
  # The prefix_url for generated shortened url
  mattr_accessor :prefix_url, :root_url
  @@root_url = "http://dev.b-fox.cn/"
  @@prefix_url = ""

  def self.generate url
    ShortenedUrl.generate url
  end

  def self.translate key
    ShortenedUrl.translate key
  end
end
