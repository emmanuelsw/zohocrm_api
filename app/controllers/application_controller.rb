class ApplicationController < ActionController::API

	private
	
	# AMS compatible with Oj
	def json_for(target, options = {})
		options[:scope] ||= self
		options[:url_options] ||= url_options
		data = ActiveModelSerializers::SerializableResource.new(target, options)
		data.as_json
	end

	def render_json(resource, meta: nil, status: :ok)
		render json: Oj.dump(json_for(resource, meta: meta), mode: :compat), status: status
	end

	def pagination(collection)
		{
			current_page: collection.current_page,
			total_count: collection.total_count
		}
	end

end
