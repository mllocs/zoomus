# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler/setup'
require 'zoomus'
require 'webmock/rspec'

RSpec.configure do |config|
  # some (optional) config here
end

def fixture(filename)
  File.dirname(__FILE__) + '/fixtures/' + filename
end

def json_response(key)
  open(fixture(key + '.json')).read
end

def zoomus_url(url)
  /https:\/\/api.zoom.us\/v2#{url}.*/
end

def zoomus_client
  Zoomus.new
end

def filter_key(hash, key)
  copy = hash.dup
  copy.delete(key)
  copy
end
