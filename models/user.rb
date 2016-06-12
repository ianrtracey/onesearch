require 'data_mapper'
require 'bcrypt'

class User
	include DataMapper::Resource
	include BCrypt


	property :id, 			Serial, :key => true
	property :email, 		String, :length => 3..50
	property :password,     BCryptHash
	property :keychain, Json, default: {}


	def authenticate(attempted_password)
		if self.password == attempted_password
			return true
		end
		return false
	end

	def add_token(service_name, token)
		keychain = self.get_keychain
		keychain[service_name] = token
		self.keychain = keychain
		begin
			self.save # always fails the first time, significant bug (frozen class)
		rescue
			puts "first saving failed"
		end
		self.save
	end

	def get_keychain
		begin
			self.keychain # always fails the first time due to Frozen class
		rescue
			puts "first keychain access failed"
		end
		self.keychain
	end




end