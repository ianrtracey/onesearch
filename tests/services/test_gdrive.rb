ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../../services/gdrive.rb'
require_relative '../../config/config.rb'

class TestGDrive < Test::Unit::TestCase

	include Rack::Test::Methods

	@@gdrive = GDrive.new

	def test_implemented_method
		assert_respond_to @@gdrive, :list_folder
		assert_respond_to @@gdrive, :search
	end

	def test_dropbox_list_folders
		assert_not_nil @@gdrive.list_folder("/")
	end

	def test_search
		assert_not_nil @@gdrive.search("sponsors")
	end
end