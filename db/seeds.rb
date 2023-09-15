# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create 100 walkers
100.times do
  Walker.create!(
    email:                Faker::Internet.email,
    first_name:           Faker::Name.first_name,
    last_name:            Faker::Name.last_name,
    avatar_url:           Faker::Avatar.image,
    hourly_rate_in_cents: rand(Walker::MIN_HOURLY_RATE_IN_CENTS..Walker::MAX_HOURLY_RATE_IN_CENTS),
    radius:               rand(1..100),
    latitude:             rand(38.5..40.5),
    longitude:            rand(-104.0..-103.0),
  )
end

# Create availabilities for each walker
Walker.all.each do |walker|
  rand(10..100).times do
    start_at = rand(0..30).days.from_now.beginning_of_day + rand(0..23).hours + rand(0..59).minutes
    walker.availabilities.create!(
      start_at: start_at,
      end_at:   start_at + rand(30..480).minutes,
    )
  end
end

# Create 100 owners
100.times do
  Owner.create!(
    email:      Faker::Internet.email,
    latitude:   rand(38.5..40.5),
    longitude:  rand(-104.0..-103.0),
  )
end

# Create 1000 addresses
1000.times do
  Address.create!(
    street_address: Faker::Address.street_address,
    city:           Faker::Address.city,
    state:          Faker::Address.state_abbr,
    postal_code:    Faker::Address.zip_code,
    country_code:   Faker::Address.country_code,
    latitude:       rand(38.5..40.5),
    longitude:      rand(-104.0..-103.0),
  )
end
