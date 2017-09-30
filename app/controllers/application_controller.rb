class ApplicationController < ActionController::API

	# AMS compatible with Oj
	def json_for(target, options = {})
		options[:scope] ||= self
		options[:url_options] ||= url_options
		data = ActiveModelSerializers::SerializableResource.new(target, options)
		data.as_json
	end

end
