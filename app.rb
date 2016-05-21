require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/cross_origin'
require './services/dropbox'
require './services/gdrive'
require './aggregator/aggregator'
require './config/config'
require 'json'

include Config::Dropbox
include ServiceConfig::Dropbox\

gdrive  = GDrive.new
dropbox = Dropbox.new
services = [gdrive, dropbox]

aggregator = Aggregator.new(services)

set :public_folder, 'public'

	configure do
		enable :cross_origin
	end


	get "/" do
		File.read(File.join('public', 'index.html'))
	end

	get "/search/:query" do
		results = aggregator.search(params[:query])
		return JSON.generate({:items => results})
	end



