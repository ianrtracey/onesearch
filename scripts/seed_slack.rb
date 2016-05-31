require './services/slack'
require './db/database'
require './models/document'
require './models/service'
require 'JSON'
slack = Slack.new
Database::DB.connect


def format_file(file)
	return {:name => file["name"], :kind => file["filetype"], :source => "Slack",
	 :icon => "https://upload.wikimedia.org/wikipedia/en/7/76/Slack_Icon.png",
	 :url => file["permalink"] }
end


body = slack.list
pages = JSON.parse(body)["paging"]

slack_service = Service.find_by(:name => "Slack")
if slack_service.nil?
	print "Slack service not found"
	exit(1)
end


files_to_be_created = []
(1..pages["pages"]).each do |page|
	body = slack.list(page) 
	files = JSON.parse(body)["files"]
	files = files.map(&method(:format_file))
	files_to_be_created << files
end

files_to_be_created.flatten!

ActiveRecord::Base.transaction do
	created_docs = Document.create(files_to_be_created)
end

slack_service.documents << created_docs





