ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../../services/gdrive.rb'
require_relative '../../config/config.rb'

class TestAggregator < Test::Unit::TestCase

	include Rack::Test::Methods

	gdrive = GDrive.new
	dropbox = Drobox.new

	@@aggregator = Aggregator.new

	def test_implemented_methods
		assert_respond_to Aggregator
	end

end