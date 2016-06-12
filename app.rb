require 'bundler'
Bundler.require

require './services/dropbox'
require './services/gdrive'
require './config/config'
require './db/database'

require './models/document'
require './models/service'
require './models/user'

require 'data_mapper'
require 'digest/sha1'
require 'sinatra-authentication'

class OneSearch < Sinatra::Base


	include Config::Dropbox
	include Config::Slack
	include ServiceConfig::Dropbox
	include ServiceConfig::Slack
	register Sinatra::Flash

	set :public_folder, 'public'

	use Rack::Session::Cookie, :secret => 

	configure do
		enable :cross_origin
		enable :sessions
	end


	before do
		if request.body.read.size > 0
		request.body.rewind
		@params = JSON.parse request.body.read
		p params
		end
	end


	get "/" do
		File.read(File.join('public', 'index.html'))
	end

	get "/search/:query" do
		docs = Document.where("name like ?", "%#{params[:query]}%")
		results = docs.map{ |doc| doc.attributes }
		return JSON.generate({:items => results})
	end

	get '/services' do
		results = Service.all.map{ |service| service.attributes.merge(:count => 0) }
		return JSON.generate({:services => results})
	end

	get '/services/:service/auth' do
		oauth_uri = SLACK_OAUTH_BASE_URI
		oauth_uri += "?client_id=#{SLACK_CLIENT_ID}"
		oauth_uri += "?scope=#{SLACK_SCOPE}"
		puts "redirect: #{oauth_uri}"
		redirect oauth_uri
	end

	get '/oauth2/callback' do
		puts "oauth2  callback"
	end

end


