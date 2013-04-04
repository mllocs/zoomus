require 'httparty'
require 'json'

module Zoomus
  class Client

    include HTTParty

    include Utils
    include Actions::User
    include Actions::Meeting

    base_uri 'https://api.zoom.us/v1'

    def initialize(*args)

      options = args.extract_options!

      raise argument_error("api_key and api_secret") unless options[:api_key] and options[:api_secret]

      self.class.default_params :api_key => options[:api_key],
                                :api_secret => options[:api_secret]
    end

  end
end
