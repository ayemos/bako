require "bundler/setup"
require "bako"

require "simplecov"
SimpleCov.start

require 'pathname'

module SpecHelper
  def fixture_root
    Pathname.new(__FILE__).dirname.join('fixtures')
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include(SpecHelper)
end

