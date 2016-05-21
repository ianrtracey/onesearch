ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../services/gdrive.rb'
require_relative '../services/dropbox.rb'
require_relative '../aggregator/aggregator.rb'
require_relative '../config/config.rb'

class TestAggregator < Test::Unit::TestCase

	include Rack::Test::Methods

	gdrive = GDrive.new
	dropbox = Dropbox.new

	services = [gdrive, dropbox]

	@@aggregator = Aggregator.new(services)

	def test_implemented_methods
		assert_respond_to @@aggregator, :search
	end

	def test_services
		assert_false @@aggregator.services.empty?
	end

	def test_search
		assert_false @@aggregator.search("sponsors").empty?
		assert_true  @@aggregator.search("sponsors").size == @@aggregator.services.size
	end

end