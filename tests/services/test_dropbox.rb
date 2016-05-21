ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../../services/dropbox.rb'
require_relative '../../config/config.rb'

class  TestDropbox < Test::Unit::TestCase

	include Rack::Test::Methods
	include Config::Dropbox

	@@dropbox = Dropbox.new(DROPBOX_ACCESS_TOKEN)


	def test_implemented_method
		assert_respond_to @@dropbox, :list_folder
		assert_respond_to @@dropbox, :search
	end

	def test_dropbox_list_folders
		assert_equal(@@dropbox.access_token,DROPBOX_ACCESS_TOKEN)
		assert_equal(@@dropbox.list_folder("").status, 200)
		assert !@@dropbox.list_folder("").nil?
	end

	def test_search
		assert_equal @@dropbox.search("ruby").status, 200
	end
end