# frozen_string_literal: true

require 'faraday'
require 'fileutils'
require 'nokogiri'
require 'pry-byebug'

BASE_URL = ENV['BASE_URL'] || 'http://localhost:9001'
ENV['AWS_ACCESS_KEY_ID'] = 'foo'
ENV['AWS_SECRET_ACCESS_KEY'] = 'bar'

RSpec.configure do |config|
  config.before(:suite) do
    # Create a temp directory if it doesn't exist
    Dir.mkdir './temp' unless File.directory? 'temp'
    # Clear it out to avoid any issues
    FileUtils.rm_rf('temp/.', secure: true)
  end
end

def xml(location)
  Nokogiri::XML(location) do |config|
    config.strict.noblanks
  end
end
