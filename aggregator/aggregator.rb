# used for aggregating search results across multiple services
# as well as defining the format of the results
require_relative '../services/service_config'
require_relative '../services/service'

class Aggregator


	include ServiceConfig
	include Service

	def initialize(services)
		if !valid_services?(services)
			@services = []
			raise Service::MissingMethods, "in Aggregator"
		else 
			@services = services
		end
	end

	def valid_services?(services)
		service_results = services.map do |service|
			return {:service => service.name, :is_valid? => Service.validate_service(service) }
		end
		puts "service resutls: "
		p service_results
		invalid_service = service_results.find {|service_result| service_result[:is_valid?] == false }
		if !invalid_service.nil?
			return false
		end

		return true
	end

	def services
		@services
	end


	def search(query)
		puts "Services: #{@services}"
		results = []
		@services.each do |service|
			resp = service.search(query)
			results << {:source => service.name, :results => service.format_results(resp)} 
		end
		return results
	end




end