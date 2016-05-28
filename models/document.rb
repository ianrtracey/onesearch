require 'sinatra/activerecord'

class Document < ActiveRecord::Base
	belongs_to :service
end