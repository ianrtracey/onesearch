require_relative 'service_config'
require_relative '../config/config'
require 'httparty'

class Slack

	include Config::Slack
	include ServiceConfig::Slack

	def initialize
	end

	def name
		return NAME
	end

	def service
		return nil
	end

	def list(page=1)
		resp = HTTParty.get("https://slack.com/api/files.list?token=#{SLACK_TEST_TOKEN}&page=#{page}")
		return resp.body
	end

end
