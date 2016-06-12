require 'openssl'

module BlowFish
	def self.cipher(mode, key, data)
		cipher = OpenSSL::Cipher::Cipher.new('bf-cbc').send(mode)
	end
end