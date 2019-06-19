# zoom_rb [![CircleCI](https://circleci.com/gh/hintmedia/zoom_rb.svg?style=svg)](https://circleci.com/gh/hintmedia/zoom_rb) [![Maintainability](https://api.codeclimate.com/v1/badges/f41fdd0c73fd39c6732a/maintainability)](https://codeclimate.com/github/hintmedia/zoom_rb/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/f41fdd0c73fd39c6732a/test_coverage)](https://codeclimate.com/github/hintmedia/zoom_rb/test_coverage)

Ruby wrapper gem for zoom.us API (currently `v2`)

## Installation

Add this line to your application's Gemfile:

    gem 'zoom_rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoom_rb

## Usage

The Zoom API uses OAuth and JWT to [Authenticate](https://marketplace.zoom.us/docs/api-reference/Authentication) API request. By defaut, a JWT client will be used.

```ruby
require 'zoom'

Zoom.configure do |c|
  c.api_key = 'xxx'
  c.api_secret = 'xxx'
end

zoom_client = Zoom.new

```

To create an OAuth client, create the client directly

```ruby
require 'zoom'
zoom_client = Zoom::Clients::OAuth.new(:access_token => 'xxx', :timeout => 15)
```

With the client, access the API

```ruby
user_list = zoom_client.user_list
user_list['users'].each do |user|
  user_id = user['id']
  puts zoom_client.meeting_list(host_id: user_id)
end

begin
  user_list = zoom_client.user_list!
rescue Zoom::Error => exception
  puts 'Something went wrong'
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
