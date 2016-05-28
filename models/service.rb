require 'sinatra/activerecord'

class Service < ActiveRecord::Base
	has_many :documents, dependent: :destroy
	validates :name, uniqueness: true 
end