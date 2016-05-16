require_relative 'service_config'
require 'faraday'

class Dropbox

	include ServiceConfig::Dropbox

	attr_reader :access_token

	def initialize(access_token)
		@access_token = access_token
		@connection = Faraday.new(:url => "#{DROPBOX_API}") do |faraday|
			faraday.request :url_encoded
			faraday.response :logger
			faraday.adapter Faraday.default_adapter
			faraday.headers['Content-Type'] = 'application/json'
			faraday.headers['Authorization'] = "Bearer #{@access_token}" 
		end
	end

	def list_folder(path)
		@connection.post do |req|
			req.url "#{VERSION}/files/list_folder"
			req.body = "{
				\"path\": \"#{path}\",
				\"recursive\": false,
				\"include_media_info\":false,
				\"include_deleted\":false,
				\"include_has_explicit_shared_members\":false
			}"
		end
	end

	def search(query, path="", max_results=100)
		@connection.post do |req|
			req.url "#{VERSION}/files/search"
			req.body = "{
				\"path\": \"#{path}\",
				\"query\": \"#{query}\",
				\"start\":0,
				\"max_results\":#{max_results},
				\"mode\":\"filename\"
			}"
		end
	end

end
