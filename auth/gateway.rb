# currently relies on OAuth2 implementation flow
require 'oauth2'
require 'yaml'
require_relative './errors.rb'

class Gateway

	attr_reader :config_path, :token, :client

	include GatewayErrors
	SUPPORTED_FILETYPES = [".yml", ".yaml"]

	def initialize(config_path, token=nil)	
		@config_path = nil
		@token = nil
		@client = nil
		if validate_config(config_path)	
			@config_path = config_path
		end
	end

	def authorize(service_name, callback, options=nil)
		config = YAML::load_file(@config_path)
		if config.empty? || !config.keys.include?("services")
			raise StandardError, "config file is empty or malformed"
		end

		service = config["services"].find {|service| service["name"] == service_name } 

		if service.nil?
			raise StandardError, "service with #{service_name} not found"
		end

		@client = OAuth2::Client.new(service["client_id"], service["client_secret"],
							:site => service["site"], :authorize_url => service["authorize_url"],
							:token_url => service["token_url"])
		auth_url = @client.auth_code.authorize_url(:redirect_uri => callback, :scope => service["scope"])

		return auth_url
	end

	def get_token(oauth_code, callback)
		token = @client.auth_code.get_token(oauth_code, :redirect_uri => callback)
		return token.token
	end

	def validate_config(config_path)
		if !File.exists?(config_path)
			raise InvalidPathError
			return false
		end
		if !SUPPORTED_FILETYPES.include? File.extname(config_path) 
			raise UnsupportedFileTypeError
			return false
		end
		return true
 	end



end
