# CherryPie Rails SDK

Cherrypie Rails SDK.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cherrypie-rails-sdk', '~> 0.2.7'
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

## API Key
Your API key can be found here: https://app.cherrypie.app/settings.

## Identity function 
Every request that is logged in CherryPie needs to be associated with a specific entity. If your API's consumers are individuals, you might choose a user's UserId as their EntityKey. If your consumers are workspaces or organizations, you might choose to identify the entityKey with an OrganizationId.

The `identity function` will be called everytime a log comes in to populate the body of the request that is sent to CherryPie.


