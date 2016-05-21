ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../../services/service'

class TestService < Test::Unit::TestCase

	include Rack::Test::Methods
	include Service

	def test_included_modules
		assert_true TestService.included_modules.include?(Service)
	end

	def test_raising_missingmethod
		assert_raise Service::MissingMethod, "Dropbox"
	end

end