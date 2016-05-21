module Service

	class ServiceError < StandardError
		def initialize(service_name=nil)
			@service_name = service_name
		end

		def message
			"#{@service_name} --ServiceError"
		end
	end

	class MissingMethod < ServiceError
		def message
			super + " has missing methods"
		end
	end

	def valididate_service(service)
		methods = [:search, :format_results]
		method_results = methods.map{ |method| service.respond_to? method}
		if method_results.any? false
			return false
		end
		return true 
	end
end