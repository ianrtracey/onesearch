require './services/slack'
require './db/database'
require './models/document'
require './models/service'
require 'JSON'
slack = Slack.new

def format_file(file)
	return {:name => file["name"], :kind => file["filetype"],
	 :icon => "https://upload.wikimedia.org/wikipedia/en/7/76/Slack_Icon.png",
	 :url => file["permalink"] }
end



body = slack.list
pages = JSON.parse(body)["paging"]


slack_service = Service.first(:name => "Slack")
if slack_service.nil?
	print "Slack service not found"
	exit(1)
end

puts "pages #{pages}"

page = 1
files_to_be_created = []
body = slack.list(page) 

files = JSON.parse(body)["files"]
files = files.map(&method(:format_file))


puts files.count

files.each do |file|
	@doc = Document.new
	@doc.attributes = file
	puts "file: #{@doc.inspect}"
	@doc.save
end




