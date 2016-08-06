module Mediumite
  class Client
    def initialize(options = {})
      @options = options
    end

    def token
      @options[:token]
    end
  end
end
