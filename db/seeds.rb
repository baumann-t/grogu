puts "Destroying all data from the database"
# Destroy instances from the database
User.destroy_all
Offer.destroy_all
Booking.destroy_all


puts "Creating users"
# Create users
25.times do
  user_name = Faker::Movies::StarWars.character
  email_username = user_name.downcase.gsub(/\s+/, ".")
  user = User.new(
    username: user_name,
    email: "#{email_username}#{rand(1..100)}@test.com",
    password: "123456",
    side: ['evil', 'good', 'neutral'].sample
  )
  user.save!
  puts user.username
end

# Create offers
puts "Creating offers"


25.times do
  url = "https://akabab.github.io/starwars-api/api/id/#{rand(1..16)}.json"
  user_serialized = URI.open(url).read
  user = JSON.parse(user_serialized)
  file = URI.open(user["image"])
  rand_user = User.all.sample
  offer = Offer.new(
    title: "#{[Faker::Movies::StarWars.specie, Faker::Movies::StarWars.vehicle, Faker::Movies::StarWars.droid].sample} for #{["sale", "hire", "rent"].sample}",
    price: rand(1..1000),
    # location: Faker::Movies::StarWars.planet,
    description: "#{Faker::Movies::StarWars.quote}. #{Faker::Movies::StarWars.quote}. #{Faker::Movies::StarWars.quote}",
    address: Faker::Address.building_number
  )
  offer.latitude = Geocoder.search(offer.address).first.latitude
  offer.longitude = Geocoder.search(offer.address).first.longitude
  offer.user = rand_user
  offer.photo.attach(io: file, filename: "new#{rand(1..111111111)}.png")
  offer.save!
  puts offer.title
end


# Create bookings
puts "Creating bookings"
20.times do
  rand_user = User.all.sample
  rand_offer = Offer.all.sample
  book = Booking.new(
    user_message: Faker::Movies::StarWars.wookiee_sentence,
    start_date: Date.new(2001,2,3),
    end_date: Date.new(2003,2,3)
  )

  book.user = rand_user
  book.offer = rand_offer

  book.save!
  puts book.user_message
end
