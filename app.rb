require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/activerecord'
require './services/dropbox'
require './services/gdrive'
require './aggregator/aggregator'
require './config/config'
require './db/database'

require './models/document'
require 'json'

include Config::Dropbox
include ServiceConfig::Dropbox

gdrive  = GDrive.new
dropbox = Dropbox.new
services = [gdrive, dropbox]

aggregator = Aggregator.new(services)
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



