require_relative './api_config.rb'
class ApiResponse

	include ApiConfig

	attr_reader :response


	def initialize(docs, view_type)
		results = _generate_results(docs)
		@response = _format_results(results, view_type)
	end

	def _generate_results(docs)
		docs = docs.map{ |doc| doc.attributes }
		filtered_docs = docs.map do |doc|
			doc.reject { |key, value| ApiConfig::REJECTED_VALUES.include? key } 
		end
		return filtered_docs
	end

	def _format_results(docs, view_type)
		results = nil
		if view_type == "split"
			results = docs.group_by { |doc| doc[:source] } 
		end
		if view_type == "card"
			results = docs
		end
		return {:view_type => view_type, :results => results}
	end


end