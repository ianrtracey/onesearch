require './db/database'
require 'sinatra/activerecord/rake'

db = Database::DB.new