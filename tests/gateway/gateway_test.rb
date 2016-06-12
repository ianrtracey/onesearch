ENV['RACK_ENV'] = 'test'

require 'test-unit'
require 'rack/test'
require_relative '../../auth/gateway'

class TestGateway < Test::Unit::TestCase

	include Rack::Test::Methods

	def test_invalid_creation
		assert_raise do
			Gateway.new("./path/doesnot/exist.yml")
		end
		assert_raise do 
			Gateway.new("./invalid_type.txt")
		end 
		assert_nothing_raised do
			Gateway.new("./valid.yml")
		end
		assert_nothing_raised do
		  Gateway.new("./valid.yaml")
		end
	end

	def test_config_path
		@gateway = Gateway.new("./valid.yml")
		assert_not_nil @gateway.config_path
	end


end