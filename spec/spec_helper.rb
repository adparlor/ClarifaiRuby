$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
# require "codeclimate-test-reporter"
# CodeClimate::TestReporter.start

require 'clarifai_ruby'
require 'pry'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'
end

ClarifaiRuby.configure do |config|
  config.base_url = 'https://api.clarifai.com'
  config.version_path = '/v2'
  config.api_key = 'api_key'
end
