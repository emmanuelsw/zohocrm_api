class Lead < ApplicationRecord

	validates :name, presence: true
	validates :company, presence: true
	validates :lead_source, presence: true
	validates :phone, presence: true, length: { maximum: 10 }
	validates :mobile, presence: true, length: { maximum: 10 }

	after_create :send_actioncable
	ransack_alias :lead, :name_or_company_or_phone_or_mobile

	def self.filter_page(page, size)
		self.order(created_at: :desc).page(page).per(size)
	end

	def self.add_from_zoho(lead_id)
		if !lead_id.nil? and lead_id.size > 2 and !letters?(lead_id)
			RubyZoho::Crm::Lead.find_by_leadid(lead_id) 
		end
	end

	def self.search_from_zoho(phone)
		RubyZoho::Crm::Lead.find_by_phone(phone) if phone.size > 2
	end

	def self.search(page, size, q)
		self.ransack(lead_cont: q).result(distinct: true).page(page).per(size) 
	end

	def self.search_leadsource(page, size, q)
		self.ransack(lead_source_cont: q).result(distinct: true).page(page).per(size) 
	end

	private
	def self.letters?(string)
		string.chars.any? { |char| ('a'..'z').include? char.downcase }
	end
	
	def send_actioncable
		data = {message: self, action: "new lead"}
		ActionCable.server.broadcast "leads", data
	end

end
