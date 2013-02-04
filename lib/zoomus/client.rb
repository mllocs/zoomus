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

      raise argument_error unless args.is_a? Array
      args = args.inject { |options, option| options.merge(option) }

      raise argument_error unless args[:api_key] and args[:api_secret]

      self.class.default_params :api_key => args[:api_key], 
                                :api_secret => args[:api_secret]
    end

  end
end