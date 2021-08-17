# frozen_string_literal: true

require_relative "lib/cherrypie_rails_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "cherrypie-rails-sdk"
  spec.version       = CherrypieRailsSdk::VERSION
  spec.authors       = ["Macro Computer Club"]
  spec.email         = ["founders@cherrypie.app"]

  spec.summary       = "CherryPie Rails SDK"
  spec.description   = "CherryPie Rails SDK"
  spec.homepage      = "https://github.com/Macro-Computer-Club/cherrypie-rails-sdk"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Macro-Computer-Club/cherrypie-rails-sdk"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "concurrent-ruby"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
