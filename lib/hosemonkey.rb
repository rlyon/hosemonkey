require "nokogiri"
require "hosemonkey/version"

module Hosemonkey
  
end

Dir[File.join('./lib/hosemonkey/ext', '*.rb')].each do |ext|
  require ext
end