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

require './auth/gateway'

class OneSearch < Sinatra::Base


	include Config::Dropbox
	include Config::Slack
	include Config::Sessions
	include ServiceConfig::Dropbox
	include ServiceConfig::Slack
	register Sinatra::Flash

	set :public_folder, 'public'

	use Rack::Session::Cookie, :secret => COOKIE_SECRET


	configure do
		enable :cross_origin
		enable :sessions
		set :gateway, Gateway.new("./config/oauth_secret.yaml")
		set :current_user, User.get(1)
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
		authorized_services = settings.current_user.get_keychain.keys
		results.each do |res|
			puts res['name']
			if authorized_services.include? res[:name]
				res[:status] = "Enabled"
			end
		end
		return JSON.generate({:services => results})
	end

	get '/services/:service/auth' do
		url = settings.gateway.authorize(params[:service], "http://localhost:9292/oauth2/#{params[:service]}/callback")
		puts url
		return JSON.generate({:redirect_url => url})
	end

	get '/oauth2/:service/callback' do
		puts "#{params[:service]}: #{params[:code]}"
		token = settings.gateway.get_token(params["code"], "http://localhost:9292/oauth2/#{params[:service]}/callback")
		DataMapper.finalize
		@user = User.get(1)
		@user.add_token(params[:service], token)
		redirect "/services"
	end

end


