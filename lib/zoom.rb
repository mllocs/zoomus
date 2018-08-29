$:.unshift File.dirname(__FILE__)

require 'zoom/utils'
require 'zoom/actions/user'
require 'zoom/actions/meeting'
require 'zoom/actions/metrics'
require 'zoom/actions/report'
require 'zoom/actions/webinar'
require 'zoom/actions/recording'
require 'zoom/client'
require 'zoom/error'

module Zoom
  class << self
    attr_accessor :configuration

    def new
      @configuration ||= Configuration.new
      Zoom::Client.new(
        api_key: @configuration.api_key,
        api_secret: @configuration.api_secret,
        timeout: @configuration.timeout
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
