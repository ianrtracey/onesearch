require 'bundler'
Bundler.require

require './services/dropbox'
require './services/gdrive'
require './config/config'
require './db/database'

require './models/document'
require './models/service'
require './models/user'




class OneSearch < Sinatra::Base


	include Config::Dropbox
	include Config::Slack
	include ServiceConfig::Dropbox
	include ServiceConfig::Slack
	register Sinatra::Flash

	use Warden::Manager do |config|
	# tells warden how to save our user info
	config.serialize_into_session{ |user| user.id}

	# tells warden how to take what is stored in the session
	# and get a user from it
	config.serialize_from_session{ |id| User.get(id) }

	config.scope_defaults :default,

		# 'strategies' is an array of methods used for 
		# authentication
		strategies: [:password],

		# route to send the user if warden.authenticate! 
		# returns false 
		action: '/auth/unauthenticated'

	# after a login failure, failure_app specifies the 
	# app that the user is sent to
	config.failure_app = self
end

Warden::Manager.before_failure do |env, opts|
	env['REQUEST_METHOD'] = 'POST'

	env.each do |key, value|
		env[key]['_method'] = 'post' if key == 'rack.request.form_hash'
	end
end


# We now add the :password strategy that we defined above
Warden::Strategies.add(:password) do

	def valid?
		puts "valid params: #{params}"
		params['user'] && params['user']['email'] && params['user']['password']
	end

	def authenticate!
		user = User.first(username: params['user']['email'])

		if user.nil?
			throw(:warden, message: "The email you entered does not exist.")
		elsif user.authenticate(params['user']['password'])
			success!(user)
		else
			throw(:warden, message: "Invalid email and password")
		end
	end
end






set :public_folder, 'public'

	configure do
		enable :cross_origin
		enable :sessions
		set :session_secret, "@#$%^YsG}"
	end


	before do
		if request.body.read.size > 0
		request.body.rewind
		@params = JSON.parse request.body.read
		p params
		end
	end

	get "/auth/login" do
		"please login here"
	end

	post '/auth/login' do
		env['warden'].authenticate!

		flash[:session] = "Successfully logged in"

		if session[:return_to].nil?
			redirect '/'
		else
			redirect session[:return_to]
		end
	end

	get '/auth/logout' do
		env['warden'].raw_session.inspect
		env['warden'].logout
		flash[:success] = 'Successfully logged out'
		redirect '/'
	end

	post '/auth/unauthenticated' do
		session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

		flash[:error] = env['warden.options'][:message] || "You must log in"
		redirect '/auth/login'
	end

	get '/protected' do
		env['warden'].authenticate!
	end

	post '/test' do
		puts "params: #{params["foo"]}"
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
		results = Service.all.map{ |service| service.attributes.merge(:count => service.documents.count) }
		return JSON.generate({:services => results})
	end

	get '/services/:service/auth' do
		oauth_uri = SLACK_OAUTH_BASE_URI
		oauth_uri += "?client_id=#{SLACK_CLIENT_ID}"
		oauth_uri += "?scope=#{SLACK_SCOPE}"
		puts "redirect: #{oauth_uri}"
		redirect oauth_uri
	end

end


