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
				render json: Oj.dump(json_for(@lead), mode: :compat), status: :201
			else
				render json: { errors: @lead.errors.full_messages }, status: 422
			end
		else
			render json: { errors: 'Lead ID does not exist in the Zoho CRM API.' }, status: 422
		end
	end

	# Search by phone in the Zoho API
	def search_by_phone
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
		@leads = Lead.ransack(lead_cont: params[:q]).result(distinct: true)
		render json: Oj.dump(@leads.as_json, mode: :compat), status: :ok
	end

	# Search by lead source
	def search_by_leadsource
		@leadsources = Lead.ransack(lead_source_cont: params[:q]).result(distinct: true)
		render json: Oj.dump(@leadsources.as_json, mode: :compat), status: :ok
	end

	private
	def lead_params
		params.require(:lead).permit(:name, :company, :phone, :mobile, :lead_source, :lead_id)
	end

end
