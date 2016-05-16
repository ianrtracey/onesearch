ENV['RACK_ENV'] = 'test'

require './app.rb'
require 'test-unit'
require 'rack/test'
require './services/connection'
require './services/dropbox'
require_relative '../config/config.rb'

class TestConnection < Test::Unit::TestCase
	include Rack::Test::Methods
	include Config::Dropbox

	def test_dropbox_list_folders
		dropbox = Dropbox.new(DROPBOX_ACCESS_TOKEN)
		assert_equal(dropbox.access_token,DROPBOX_ACCESS_TOKEN)
		assert_equal(dropbox.list_folder("").status, 200)
		assert !dropbox.list_folder("").nil?
	end

	def test_search
		dropbox = Dropbox.new(DROPBOX_ACCESS_TOKEN)
		assert_equal dropbox.search("ruby").status, 200
	end

end