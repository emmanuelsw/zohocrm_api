class LeadSerializer < ActiveModel::Serializer
  attributes :id, :name, :company, :phone, :mobile, :lead_source
end
