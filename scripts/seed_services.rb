require './models/service'
require './db/database'
require './services/service_config'
require './services/constants'

Database::DB.connect
include ServiceConstants

def get_field(service, field)
	return eval("ServiceConfig::#{service.to_s}::#{field}")
end

services = ServiceConfig.constants.map do |service|

	{:name => get_field(service, "NAME"), :url => get_field(service, "ICON_URL"),
	 :description => "api", :status => DISABLED}

end

p services

Service.create(services)