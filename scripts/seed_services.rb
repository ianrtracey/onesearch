require './models/service'
require './db/database'
require './services/service_config'
require './services/constants'

include Database
include ServiceConstants

def get_field(service, field)
	return eval("ServiceConfig::#{service.to_s}::#{field}")
end

services = ServiceConfig.constants.each do |service|
	@service = Service.new(
		:name => get_field(service, "NAME"), :logo => get_field(service, "ICON_URL"),
	 	:description => "api", :status => DISABLED
	 )
	p @service.save!
end

p services