require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './services/dropbox'
require './config/config'

include Config::Dropbox
include ServiceConfig::Dropbox
dropbox = Dropbox.new(DROPBOX_ACCESS_TOKEN)


	get "/" do
	end

	get "/search/:query" do
		return dropbox.search(params[:query]).body 
	end



