require 'faker'
Donor.destroy_all
Cause.destroy_all
Donation.destroy_all

20.times {Donor.create( name:Faker::Name.unique.name)}

10.times {Cause.create(name:Faker::Company.name, category:Faker::Company.industry, status:Faker::Number.within(1..10))}

50.times {Donation.create(amount:Faker::Number.number(3), donor_id: Donor.all.sample.id, cause_id:Cause.all.sample.id)}
