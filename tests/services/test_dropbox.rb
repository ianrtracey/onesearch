ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../../services/dropbox.rb'
require_relative '../../config/config.rb'

class  TestDropbox < Test::Unit::TestCase

	include Rack::Test::Methods
	include Config::Dropbox

	@@dropbox = Dropbox.new


	def test_implemented_method
		assert_respond_to @@dropbox, :list_folder
		assert_respond_to @@dropbox, :search
		assert_respond_to @@dropbox, :name
		assert_respond_to @@dropbox, :format_results
	end

	def test_name
		assert_not_nil @@dropbox.name
	end

	def test_dropbox_list_folders
		assert_equal(@@dropbox.list_folder("").status, 200)
		assert !@@dropbox.list_folder("").nil?
	end

	def test_search
		assert_equal @@dropbox.search("ruby").status, 200
	end

	def test_format_results
		response = @@dropbox.search("sponsors")
		formatted_response = @@dropbox.format_results(response)
		assert_true formatted_response.is_a? Array
	end
end