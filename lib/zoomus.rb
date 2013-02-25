require 'zoomus/utils'
require 'zoomus/actions/user'
require 'zoomus/actions/meeting'
require 'zoomus/client'

module Zoomus

  class << self
    def new(*arg)
      Zoomus::Client.new(*arg)
    end
  end

  def self.included(base)
    base.class_eval do
      attr_accessor :zoomus_singleton
      def zoomus_setup(api_key, api_secret)
        @zoomus_singleton = Client.new(api_key, api_secret)
      end
    end
  end

end
