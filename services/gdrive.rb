require 'fileutils'
require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require_relative 'service_config'
require_relative '../config/config'

class GDrive

	include Config::GDrive
	include ServiceConfig::GDrive

	cert_path = Gem.loaded_specs['google-api-client'].full_gem_path+'/lib/cacerts.pem'
	ENV['SSL_CERT_FILE'] = cert_path

	OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
	APPLICATION_NAME = 'Drive API Ruby Quickstart'
	CLIENT_SECRETS_PATH = 'client_secret.json'
	CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
	                             "drive-ruby-quickstart.yaml")
	SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

	def initialize 
		@service = Google::Apis::DriveV3::DriveService.new
		@service.client_options.application_name = APPLICATION_NAME
		@service.authorization = authorize
	end

	def name
		return NAME
	end

	def service
		return @service
	end

	def authorize
	  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

	  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
	  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
	  authorizer = Google::Auth::UserAuthorizer.new(
	    client_id, SCOPE, token_store)
	  user_id = 'default'
	  credentials = authorizer.get_credentials(user_id)
	  if credentials.nil?
	    url = authorizer.get_authorization_url(
	      base_url: OOB_URI)
	    puts "Open the following URL in the browser and enter the " +
	         "resulting code after authorization"
	    puts url
	    code = gets
	    credentials = authorizer.get_and_store_credentials_from_code(
	      user_id: user_id, code: code, base_url: OOB_URI)
	  end
	  credentials
	end

	def list_folder(path)
		response = @service.list_files(page_size: 10,
                                  fields: 'nextPageToken, files(id, name)')
		puts 'Files:'
		puts 'No files found' if response.files.empty?
		return response.files
	end

	def search(query)
		page_token = nil
		response = @service.list_files(q: "name contains '#{query}'",
                                      spaces: 'drive',
                                      fields:'nextPageToken, files(id, name)',
                                      page_token: page_token)
		return response.files
	end

	def format_results(response)
		return response.map(&method(:convert_file_obj))
	end

	def convert_file_obj(obj)
		return {:title => obj.name, :url => "http://google.com"}
	end


end
