# frozen_string_literal: true

require 'httparty'
require 'json'

module Zoom
  class Client
    include HTTParty
    # include Actions::Account
    # include Actions::Chat
    # include Actions::Group
    # include Actions::IMGroup
    # include Actions::M323Device
    include Actions::User
    include Actions::Meeting
    include Actions::Metrics
    include Actions::Webinar
    include Actions::Report
    include Actions::Recording

    base_uri 'https://api.zoom.us/v2'

    def initialize(*args)
      options = Utils.extract_options!(args)

      raise Utils.argument_error('api_key and api_secret') unless options[:api_key] &&
                                                                  options[:api_secret]
      self.class.default_params(
        api_key: options[:api_key],
        api_secret: options[:api_secret]
      )
      self.class.default_timeout(options[:timeout])
    end
  end
end
