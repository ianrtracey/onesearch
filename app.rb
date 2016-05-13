require 'rubygems'
require 'bundler/setup'
require 'sinatra'
module OneSearch
	class App < Sinatra::Base

	  def initialize(app)
	  	super(app)
	  end

		get '/hi' do
			"Hello world"
		end

	end
end