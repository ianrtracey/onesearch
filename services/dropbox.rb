require './service'
class Dropbox < Service
	include ServiceConfig::Drobox

	attr_reader :connection

	def initialize(connection)
		@connection = connection
	end

end
