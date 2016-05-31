module ServiceConfig

	module Dropbox
	 	DROPBOX_API = "https://api.dropboxapi.com/"
		VERSION = "2"
		NAME = "Dropbox"
	end

	module GDrive
		OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
		NAME = "Google Drive"
	end

	module Slack
		NAME = "Slack"
		SLACK_OAUTH_BASE_URI = "https://slack.com/oauth/authorize"
		SLACK_SCOPE = "files:read"
	end
end