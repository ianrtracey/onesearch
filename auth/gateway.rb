# currently relies on OAuth2 implementation flow
require 'httparty'

class Gateway

	include HTTParty
	base_uri 'https://slack.com/oauth/authorize'

end