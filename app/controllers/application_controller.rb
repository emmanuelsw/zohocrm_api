class ApplicationController < ActionController::API

	# AMS compatible with Oj
	def json_for(target, options = {})
		options[:scope] ||= self
		options[:url_options] ||= url_options
		data = ActiveModelSerializers::SerializableResource.new(target, options)
		data.as_json
	end

	def pagination(collection)
		{
			current_page: collection.current_page,
			next_page: collection.next_page,
			prev_page: collection.prev_page,
			total_pages: collection.total_pages,
			total_count: collection.total_count
		}
	end

end
