module Service

	class ServiceError < StandardError
		def initialize(service_name=nil)
			@service_name = service_name
		end

		def message
			"#{@service_name} --ServiceError"
		end
	end

	class MissingMethods < ServiceError
		def message
			super + " has missing methods"
		end
	end

	def validate_service(service)
		methods = [:name, :search, :format_results]
		method_results = methods.map{ |method| service.respond_to? method}
		if method_results.all?  # checks if all are true
			return true
		end
		return false
	end
	module_function :validate_service

end