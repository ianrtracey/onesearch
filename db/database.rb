require 'data_mapper'
require_relative '../config/database_config.rb'
module Database

	include DatabaseConfig

	DataMapper::Logger.new($stdout, :debug)
	DataMapper.setup(:default, "postgres://#{PSQL_USERNAME}:#{PSQL_PASSWORD}@localhost/#{PSQL_DB_NAME}")
	DataMapper.finalize # checks validity and properties


end

