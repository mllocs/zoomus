# Zoomus Gem

Ruby wrapper gem for zoom.us API v1.

## Installation

Add this line to your application's Gemfile:

    gem 'zoomus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoomus

## Usage

    require 'zoomus'
    zoomus_client = Zoomus.new(:api_key => "xxx", :api_secret => "xxx")
    user_list = zoomus_client.user_list
    user_list["users"].each do |user|
      user_id = u["id"]
      puts zoomus_client.meeting_list(:host_id => user_id)
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
