require "sawyer"

module Mediumite
  class Client
    def initialize(options = {})
      @options = options
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

    def request(method, path, data = {}, options = {})
      agent.call(method, URI::Parser.new.escape(path.to_s), data, options).data
    end

    def user
      @user ||= request :get, "me"
    end
  end
end
