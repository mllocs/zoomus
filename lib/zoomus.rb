$:.unshift File.dirname(__FILE__)

require 'zoomus/utils'
require 'zoomus/actions/user'
require 'zoomus/actions/meeting'
require 'zoomus/actions/report'
require 'zoomus/actions/webinar'
require 'zoomus/actions/recording'
require 'zoomus/client'
require 'zoomus/error'

module Zoomus
  class << self
    attr_accessor :configuration

    def new
      @configuration ||= Configuration.new
      Zoomus::Client.new(
        :api_key => @configuration.api_key,
        :api_secret => @configuration.api_secret,
        :timeout => @configuration.timeout
      )
    end

    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end
  end

  class Configuration
    attr_accessor :api_key, :api_secret, :timeout

    def initialize
      @api_key = @api_secret = 'xxx'
      @timeout = 15
    end
  end
end
