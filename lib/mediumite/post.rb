require "json"

module Mediumite
  class Post
    def initialize(content)
      @content = content
    end

    def publication_id
      @content[:publication_id]
    end

    def under_publication?
      !!@content[:publication_id]
    end

    def to_param
      {
        title: @content[:title] ||= "",
        contentFormat: @content[:format] ||= "markdown",
        content: @content[:body],
        canonicalUrl: @content[:canonical_url],
        tags: @content[:tags],
        publishStatus: @content[:publish_status] ||= "draft"
      }.to_json
    end
  end
end
