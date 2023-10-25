# rubocop:disable Rails/Output
require 'faker'

Membership.delete_all
Event.delete_all
User.delete_all
Troop.delete_all

puts 'Creating Troops'
troop1 = Troop.create!(name: 'Local Troop 1', number: '123', address: Address.new(address_text: "123 Main St\nAnytown, USA"))
troop2 = Troop.create!(name: 'Local Troop 2', number: '456', address: Address.new(address_text: '456 A St\nAnytown, USA'))

puts 'create admin user'
password = 'testing123'
admin = User.create!(
  email: 'stevemac72@gmail.com',
  password:,
  password_confirmation: password,
  name: 'Steven McFarlane',
  admin: true,
  confirmed_at: Time.now
)
admin.memberships.create!(troop: troop1, role: :leader, current: true)
admin.memberships.create!(troop: troop1, role: :leader)

puts 'create leaders'
leader1 = User.create!(
  email: 'leader1@test.com',
  password:,
  password_confirmation: password,
  name: 'Jane Leader1',
  confirmed_at: Time.now
)
leader1.memberships.create!(troop: troop1, role: :leader, current: true)

leader2 = User.create!(
  email: 'leader2@test.com',
  password:,
  password_confirmation: password,
  name: 'Sarah Leader2',
  confirmed_at: Time.now
)
leader2.memberships.create!(troop: troop2, role: :leader, current: true)

# Create 4 scouts for each troop
# troop 1
puts 'create scout_parent users'
4.times do
  last_name = Faker::Name.last_name
  mom_name = "#{Faker::Name.female_first_name} #{last_name}"
  mom = User.create!(
    email: "#{mom_name.downcase.gsub(' ', '_')}@test.com",
    password:,
    password_confirmation: password,
    name: mom_name,
    confirmed_at: Time.now
  )
  troop1.memberships.create!(user: mom, role: :scout_parent, current: true)

  dad_name = "#{Faker::Name.male_first_name} #{last_name}"
  dad = User.create!(
    email: "#{dad_name.downcase.gsub(' ', '_')}@test.com",
    password:,
    password_confirmation: password,
    name: dad_name,
    confirmed_at: Time.now
  )
  troop1.memberships.create!(user: dad, role: :scout_parent, current: true)
end

# troop 2
4.times do
  last_name = Faker::Name.last_name
  mom_name = "#{Faker::Name.female_first_name} #{last_name}"
  mom = User.create!(
    email: "#{mom_name.downcase.gsub(' ', '_')}@test.com",
    password:,
    password_confirmation: password,
    name: mom_name,
    confirmed_at: Time.now
  )
  troop2.memberships.create!(user: mom, role: :scout_parent, current: true)

  dad_name = "#{Faker::Name.male_first_name} #{last_name}"
  dad = User.create!(
    email: "#{dad_name.downcase.gsub(' ', '_')}@test.com",
    password:,
    password_confirmation: password,
    name: dad_name,
    confirmed_at: Time.now
  )
  troop2.memberships.create!(user: dad, role: :scout_parent, current: true)
end

# create events for each troop
puts 'create events'
10.times do
  troop1.events.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    starts_at: Faker::Time.between(from: 1.month.ago, to: 1.month.from_now),
    ends_at: Faker::Time.between(from: 1.month.ago, to: 1.month.from_now),
    user: leader1,
    address: Address.new(address_text: "123 Main St\nAnytown, USA")
  )

  troop2.events.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    starts_at: Faker::Time.between(from: 1.month.ago, to: 1.month.from_now),
    ends_at: Faker::Time.between(from: 1.month.ago, to: 1.month.from_now),
    user: leader2,
    address: Address.new(address_text: "456 A St\nAnytown, USA")
  )
end

# rubocop:enable Rails/Output
