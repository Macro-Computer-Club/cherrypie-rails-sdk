# CherryPie Rails SDK

Cherrypie Rails SDK.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cherrypie-rails-sdk', '~> 0.2.6'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cherrypie-rails-sdk

## Usage

```
# config/application.rb

require_relative "boot"

require "rails/all"
require 'cherrypie_rails_sdk'

Bundler.require(*Rails.groups)

module ExampleApp
  class Application < Rails::Application
    ...
  config.middleware.use(CherrypieRailsSdk::Middleware, "<TOKEN>",
  lambda{ |request| {
    # request: ActionDispatch::Request
    "entityKey"=> "1", "name"=> "RAILS"
    } },
  )
  end
end
```
