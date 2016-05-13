ENV['RACK_ENV'] = 'test'

require '../app.rb'
require 'test-unit'
require 'rack/test'
require '../services/connection'
require '../services/dropbox'

class TestConnection < Test::Unit::TestCase
	include Rack::Test::Methods

	def test_dropbox_connection

	end

end