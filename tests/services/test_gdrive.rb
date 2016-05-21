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
		assert_respond_to @@gdrive, :name
		assert_respond_to @@gdrive, :format_results
	end

		def test_name
		assert_not_nil @@gdrive.name
	end

	def test_dropbox_list_folders
		assert_not_nil @@gdrive.list_folder("/")
	end

	def test_search
		assert_not_nil @@gdrive.search("sponsors")
	end

	def test_format_results
		response = @@gdrive.search("sponsors")
		formatted_response = @@gdrive.format_results(response)
		assert_true formatted_response.is_a? Array
	end
end