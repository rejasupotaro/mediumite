require "sawyer"

module Mediumite
  class Client
    def initialize(options = {})
      @options = options
    end

    def inspect
      inspected = super
      inspected = inspected.gsub! token, "#{'*'*token.length}" if token
      inspected
    end

    def token
      @options[:token]
    end

    def agent
      @agent ||= Sawyer::Agent.new("https://api.medium.com/v1") do |http|
        http.headers[:content_type] = "application/json"
        http.authorization "Bearer", token
      end
    end

    def request(method, path, data = {})
      agent.call(method, URI::Parser.new.escape(path.to_s), data).data.data
    end

    def user
      @user ||= request(:get, "me")
    end

    def get_publications
      request(:get, "users/#{user.id}/publications")
    end

    def create_post(post)
      if post.under_publication?
        request(:post, "publications/#{post.publication_id}/posts", post.to_json)
      else
        request(:post, "users/#{user.id}/posts", post.to_json)
      end
    end
  end
end
