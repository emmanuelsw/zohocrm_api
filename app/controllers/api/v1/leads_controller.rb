class Api::V1::LeadsController < ApplicationController

	def index
		lead = RubyZoho::Crm::Lead.find_by_email('Carissa-batman@yahoo.com')
		render json: lead
	end

	def create
		l = RubyZoho::Crm::Lead.find_by_email('Carissa-batman@yahoo.com').first
		
		@lead = Lead.new
		@lead.name = l.full_name
		@lead.company = l.company
		@lead.phone = l.phone
		@lead.mobile = l.mobile
		@lead.lead_source = l.lead_source

		if @lead.save
			render json: @lead, status: :created
		else
			render json: { errors: @lead.errors }, status: :unprocessable_entity
		end

	end

	def lead_params
		params.require(:lead).permit(:name, :company, :phone, :mobile, :lead_source, :lead_id)
	end

end
