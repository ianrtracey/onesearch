# used for aggregating search results across multiple services
# as well as defining the format of the results
require_relative '../services/service_config'
class Aggregator


	include ServicesConfig

	def initialize(services)
		if @services.any? { |service| !service.respond_to? search }
			raise
		@services = services
	end


	def search(query)
		return @services.map(&method())
	end




end