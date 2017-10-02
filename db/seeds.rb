Lead.destroy_all

5000.times do
	Lead.create!(
		name: Faker::Name.name, 
		company: Faker::Company.name, 
		phone: Faker::Number.number(10), 
		mobile: Faker::Number.number(10), 
		lead_source: Faker::Commerce.department(2)
	)
end

p "Created #{Lead.count} of 10000 leads."

5000.times do
	Lead.create!(
		name: Faker::Name.name, 
		company: Faker::Company.name, 
		phone: Faker::Number.number(10), 
		mobile: Faker::Number.number(10), 
		lead_source: Faker::Commerce.department(2)
	)
end

p "Created #{Lead.count} of 10000 leads."