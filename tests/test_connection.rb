ENV['RACK_ENV'] = 'test'

require '../app.rb'
require 'test/unit'
require 'rack/test'

class TestConnection < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_app_available
		get '/'
		assert_true_last_response.ok?
		assert_equal "OneSearch"
	end
end