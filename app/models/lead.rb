class Lead < ApplicationRecord

	validates :name, presence: true
	validates :company, presence: true
	validates :lead_source, presence: true
	validates :phone, presence: true, length: { maximum: 10 }
	validates :mobile, presence: true, length: { maximum: 10 }

	ransack_alias :lead, :name_or_company_or_phone_or_mobile

end
