require './models/service'
require './db/database'
require './services/service_config'
require './services/constants'

Database::DB.connect
include ServiceConstants

names = ServiceConfig.constants.map do |service|
	eval("ServiceConfig::#{service.to_s}::NAME")
end

services = names.map do |name|
	{:name => name, :description => "api", :status => DISABLED}
end

p services

Service.create(services)