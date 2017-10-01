class Api::V1::LeadsController < ApplicationController

	# Fetch all leads
	def index
		@leads = Lead.select(:id, :name, :company, :phone, :mobile, :lead_source)
		render json: Oj.dump(json_for(@leads), mode: :compat)
	end

	# Add record by Lead ID
	def create
		lead = RubyZoho::Crm::Lead.find_by_leadid(params[:lead_id])
		unless lead.nil?
			lead = lead.first
			@lead = Lead.new
			@lead.name = lead.full_name
			@lead.company = lead.company
			@lead.phone = lead.phone
			@lead.mobile = lead.mobile
			@lead.lead_source = lead.lead_source
	
			if @lead.save
				render json: Oj.dump(json_for(@lead), mode: :compat), status: :created
			else
				render json: { errors: @lead.errors.full_messages }, status: :unprocessable_entity
			end
		else
			render json: { errors: 'Lead ID does not exist in the Zoho CRM API.' }, status: :unprocessable_entity
		end
	end

	# Search by phone in the Zoho API
	def search_by_phone
		lead = RubyZoho::Crm::Lead.find_by_phone(params[:phone]) if params[:phone].size > 2
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
