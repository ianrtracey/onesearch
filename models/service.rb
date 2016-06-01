require 'data_mapper'

class Service
	include DataMapper::Resource

	property :id, 			Serial
	property :name, 		String
	property :description,  Text
	property :logo,   		String
	property :status,    	String
	property :created_at, 	DateTime
	property :last_synced,   DateTime
end