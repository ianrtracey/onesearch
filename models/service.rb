require 'data_mapper'

class Service
	include DataMapper::Resource

	property :id, 			Serial
	property :name, 		String, :required => true
	property :description,  Text
	property :logo,   		String, :length => 150
	property :status,    	String
	property :created_at, 	DateTime
	property :last_synced,   DateTime
end