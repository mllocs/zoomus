# frozen_string_literal: true

require 'httparty'
require 'json'
require 'jwt'
require 'pry'

module Zoom
  class Client
    include HTTParty
    include Actions::Account
    include Actions::Group
    include Actions::M323Device
    include Actions::User
    include Actions::Meeting
    include Actions::Metrics
    include Actions::Webinar
    include Actions::Report
    include Actions::Recording
    include Actions::IM::Chat
    include Actions::IM::Group

    base_uri 'https://api.zoom.us/v2'

    def initialize(config)
      Utils.require_params(%i[api_key api_secret], config)
      config.each { |k, v| self.instance_variable_set("@#{k}", v) }
      self.class.default_timeout(@timeout)
    end

    def access_token
      JWT.encode({ iss: @api_key, exp: Time.now.to_i + @timeout }, @api_secret, 'HS256', { typ: 'JWT' })
    end
  end
end
