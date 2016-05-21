require_relative 'service_config'
require_relative '../config/config.rb'
require 'faraday'
require 'json'

class Dropbox

	include ServiceConfig::Dropbox
	include Config::Dropbox

	attr_reader :access_token

	def name
		return NAME
	end

	def initialize
		@access_token = DROPBOX_ACCESS_TOKEN
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

	def format_results(response)
		results_hash = JSON.parse(response.body)['matches']
		return results_hash.map(&method(:convert_file_obj))
	end

	def convert_file_obj(obj)
		return {:title => obj['metadata']['name'], :url => "http://dropbox.com"}
	end

end
