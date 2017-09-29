require 'ruby_zoho'

RubyZoho.configure do |config|
  config.api_key = '0362e09774bf6a5df9c08fb23ca88c63'
	config.crm_modules = ['Leads']
	config.cache_fields = true
end