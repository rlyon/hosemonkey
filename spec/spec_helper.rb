require 'rubygems'
require 'bundler/setup'
require 'hosemonkey'

RSpec.configure do |config|
  config.mock_with :mocha
end