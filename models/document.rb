require 'data_mapper'

class Document
	include DataMapper::Resource

	property :id, 				Serial
	property :name, 			Text
	property :kind,   		Text
	property :icon,   		Text
	property :url,    		Text
	property :created_at, DateTime
	property :updated_at, DateTime
	property :deleted_at, DateTime
	property :source, String
end