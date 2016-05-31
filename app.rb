require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/activerecord'
require './services/dropbox'
require './services/gdrive'
require './config/config'
require './db/database'
require 'httparty'

require './models/document'
require './models/service'
require 'json'

include Config::Dropbox
include Config::Slack
include ServiceConfig::Dropbox
include ServiceConfig::Slack



Database::DB.connect







set :public_folder, 'public'

	configure do
		enable :cross_origin
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




