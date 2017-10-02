class Api::V1::LeadsController < ApplicationController

	# Fetch all leads
	def index
		@leads = Lead.filter_page(params[:page], params[:size])
		render json: Oj.dump(json_for(@leads, meta: pagination(@leads)), mode: :compat)
	end


	# Add record by Lead ID
	def create
		lead = Lead.add_from_zoho(params[:lead_id])
		unless lead.nil?
			lead = lead.first

			@lead = Lead.new
			@lead.name = lead.full_name
			@lead.company = lead.company
			@lead.phone = lead.phone
			@lead.mobile = lead.mobile
			@lead.lead_source = lead.lead_source
	
			if @lead.save
				render_json(@lead, status: 201)
			else
				render json: { errors: @lead.errors.full_messages }, status: 422
			end
		else
			render json: { errors: 'Lead ID does not exist.' }, status: 422
		end
	end


	# Search by phone in the Zoho API
	def search_phone
		lead = Lead.search_from_zoho(params[:phone])
		unless lead.nil?
			lead = lead.first
			json = 
				[
					name: lead.full_name,
					phone: lead.phone,
					lead_id: lead.leadid
				]
			render json: Oj.dump(json_for(json), mode: :compat), status: :ok
		else
			render json: [], status: :ok
		end
	end


	# Search by name, phone or company
	def search
		@leads = Lead.search(params[:page], params[:size], params[:q])
		render_json(@leads, meta: pagination(@leads))
	end


	# Search by lead source
	def search_leadsource
		@leads = Lead.search_leadsource(params[:page], params[:size], params[:q])
		render_json(@leads, meta: pagination(@leads))
	end


	private
	def lead_params
		params.require(:lead).permit(:name, :company, :phone, :mobile, :lead_source, :lead_id)
	end

end
