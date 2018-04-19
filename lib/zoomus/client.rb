require 'httparty'
require 'json'

module Zoomus
  class Client

    include HTTParty
    include Actions::User
    include Actions::Meeting
    include Actions::Metrics
    include Actions::Webinar
    include Actions::Report
    include Actions::Recording

    base_uri 'https://api.zoom.us/v2'

    def initialize(*args)

      options = Utils.extract_options!(args)

      raise Utils.argument_error("api_key and api_secret") unless options[:api_key] &&
                                                                  options[:api_secret]
      self.class.default_params(
        :api_key    => options[:api_key],
        :api_secret => options[:api_secret]
      )
      self.class.default_timeout(options[:timeout])
    end
  end
end
