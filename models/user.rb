require 'data_mapper'
require 'bcrypt'

class User
	include DataMapper::Resource
	include BCrypt

	property :id, 			Serial, :key => true
	property :email, 		String, :length => 3..50
	property :password, BCryptHash

	def authenticate(attempted_password)
		if self.password == attempted_password
			return true
		end
		return false
	end

end