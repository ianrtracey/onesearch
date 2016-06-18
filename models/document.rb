require 'data_mapper'

class Document
	include DataMapper::Resource

	property :id, 				Serial
	property :name, 			String
	property :kind,   		String
	property :icon,   		String
	property :url,    		String
	property :created_at, DateTime
	property :updated_at, DateTime
	property :deleted_at, DateTime
end