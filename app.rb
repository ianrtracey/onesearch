require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/cross_origin'
require './services/dropbox'
require './config/config'
require 'json'

include Config::Dropbox
include ServiceConfig::Dropbox
dropbox = Dropbox.new(DROPBOX_ACCESS_TOKEN)

set :public_folder, 'public'

	configure do
		enable :cross_origin
	end


	get "/" do
		File.read(File.join('public', 'index.html'))
	end

	get "/search/:query" do
		matches = JSON.parse(dropbox.search(params[:query]).body)['matches']
		results = matches.map{|x| {:source => ["dropbox", "gdrive", "slack"].sample, 
								   :name => x['metadata']['name'],
								   :url => "google.com"}}
		return JSON.generate({:items => results})
	end



