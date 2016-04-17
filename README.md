[![Gem Version](https://badge.fury.io/rb/micro_service-server.svg)](http://badge.fury.io/rb/micro_service-server)
[![Build Status](https://travis-ci.org/butchmarshall/ruby-micro_service-server.svg?branch=master)](https://travis-ci.org/butchmarshall/ruby-micro_service-server)

# MicroService::Server

ActiveRecord MicroService implementation that persists the details of server installations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'micro_service-server'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micro_service-server

then run

```ruby
rails generate micro_service:server:active_record
bundle exec rake db:migrate
```

## Usage

To the ActiveRecord model:

```ruby
MicroService::Server.new(...)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/butchmarshall/ruby-micro_service-server.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

