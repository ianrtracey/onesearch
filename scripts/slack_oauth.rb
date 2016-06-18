require 'yaml'
require 'oauth2'

config = YAML::load_file('./config/oauth_secret.yaml')
puts config
slack = config["services"].find {|service| service["name"] == "slack"}
puts slack
client = OAuth2::Client.new(slack["client_id"], slack["client_secret"],
							:site => slack["site"], :authorize_url => slack["authorize_url"],
							:token_url => slack["token_url"])
puts client.options

url = client.auth_code.authorize_url(:redirect_uri => "http://localhost:9292/oauth2/callback", :scope => slack["scope"])

puts "Please go to the following:"
puts url
puts "\n"
puts "Enter the resulting code:"
print ">"
code = $stdin.gets.chomp


token = client.auth_code.get_token(code, :redirect_uri => 'http://localhost:9292/oauth2/callback')
puts token.token
