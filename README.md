# Zoomus Gem

[![CircleCI](https://circleci.com/gh/hintmedia/zoomus.svg?style=svg)](https://circleci.com/gh/hintmedia/zoomus)

Ruby wrapper gem for zoom.us API (currently `v2`)

## Installation

Add this line to your application's Gemfile:

    gem 'zoomus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoomus

## Available actions

- user/create
- user/autocreate
- user/autocreate2
- user/custcreate
- user/update
- user/list
- user/pending
- user/get
- user/getbyemail
- user/delete
- user/permanentdelete
- meeting/get
- meeting/end
- meeting/create
- meeting/delete
- meeting/list
- meeting/update
- report/getaccountreport
- report/getuserreport
- report/getdailyreport
- webinar/create
- webinar/update
- webinar/delete
- webinar/list
- webinar/get
- webinar/end
- recording/list
- mc/recording/list
- recording/get
- recording/delete
- metrics/crc
- metrics/meetings
- metrics/meetingdetail

## Example
```ruby
require 'zoomus'

Zoomus.configure do |c|
  c.api_key = 'xxx'
  c.api_secret = 'xxx'
end

zoomus_client = Zoomus.new

user_list = zoomus_client.user_list
user_list['users'].each do |user|
  user_id = user['id']
  puts zoomus_client.meeting_list(:host_id => user_id)
end

begin
  user_list = zoomus_client.user_list!
rescue Zoomus::Error => exception
  puts 'Something went wrong'
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
