require "json"

module Mediumite
  class Post
    def initialize(content)
      @content = content
    end

    def to_json
      {
        title: @content[:title],
        contentFormat: @content[:format] ||= "markdown",
        content: @content[:body],
        canonicalUrl: @content[:canonical_url],
        tags: @content[:tags],
        publishStatus: @content[:publish_status] ||= "draft"
      }.to_json
    end
  end
end
