require 'zoomus/utils'
require 'zoomus/actions/user'
require 'zoomus/actions/meeting'
require 'zoomus/client'

module Zoomus
  class Client
    def new(*arg)
      Zoomus::Client.new(*arg)
    end
  end
end
