module GatewayErrors
	class UnsupportedFileTypeError < StandardError
		def initialize(msg="File is not supported by gateway")
			super
		end
	end

	class InvalidPathError < StandardError
		def initialize(msg="Can't find file path")
			super
		end
	end
end