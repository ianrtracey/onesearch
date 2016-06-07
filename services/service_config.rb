module ServiceConfig

	module Dropbox
		NAME = "Dropbox"
		ICON_URL = "http://www.underconsideration.com/brandnew/archives/dropbox_logo_detail.png"
	 	DROPBOX_API = "https://api.dropboxapi.com/"
		VERSION = "2"
	end

	module GDrive
		NAME = "Google Drive"
		ICON_URL = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Logo_of_Google_Drive.svg/500px-Logo_of_Google_Drive.svg.png"
		OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
		
	end

	module Slack
		NAME = "Slack"
		ICON_URL = "http://rethinkcanada.com/app/uploads/2015/10/slack-logo.png"
		SLACK_OAUTH_BASE_URI = "https://slack.com/oauth/authorize"
		SLACK_SCOPE = "files:read"
	end

	module Box
		NAME = "Box"
		ICON_URL = "http://lazytechguys.com/wp-content/uploads/2012/02/download.png"
	end

	module QuickBooks
		NAME = "QuickBooks"
		ICON_URL = "http://floatapp.com/wp-content/themes/float2015/ims/quickbooks-logo.png"
	end

	module Office365
		NAME = "Office365"
		ICON_URL = "http://thehivesa.co.za/store/image/cache/data/new-office-365-logo-orange-png-1888c397654-500x500.jpg"
	end

	module Hubspot
		NAME = "HubSpot"
		ICON_URL = "http://hzh6525utto3vami02sbs1mv.wpengine.netdna-cdn.com/wp-content/uploads/2015/03/hubspot-logo.png"
	end
end