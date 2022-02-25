puts "Destroying all data from the database"
# Destroy instances from the database
User.destroy_all
Offer.destroy_all
Booking.destroy_all

puts "Creating users"
# Create users
25.times do
  url = "https://akabab.github.io/starwars-api/api/id/#{rand(1..16)}.json"
  user_serialized = URI.open(url).read
  user = JSON.parse(user_serialized)
  file = URI.open(user["image"])
  user_name = Faker::Movies::StarWars.unique.character
  email_username = user_name.downcase.gsub(/\s+/, ".")
  user = User.new(
    username: user_name,
    email: "#{email_username}@test.com",
    password: "123456",
    side: ['dark', 'light', 'neutral'].sample
  )
  user.photo.attach(io: file, filename: "new#{rand(1..111111111)}.png")
  user.save!
  puts user.username
end

# Create offers
puts "Creating offers"

# variables for offers
cities = %w[London Bratislava Bucharest Reykjavik Lisbon Dubrovnik Copenhagen
            Istanbul Warsaw Zagre Vienna Ljubljana Antwerp Kraków Sofia Dublin
            Marseille Bruges Birmingham Oslo Rotterdam Edinburgh
            Saint-Petersburg Porto Madrid Venice Berlin Budapest Riga Rome Athens]

25.times do |count|
  url = "https://akabab.github.io/starwars-api/api/id/#{rand(1..16)}.json"
  user_serialized = URI.open(url).read
  user = JSON.parse(user_serialized)
  file = URI.open(user["image"])
  rand_user = User.all.sample
  location = Geocoder.search(cities[count]).first

  offer = Offer.new(
    title: "#{[Faker::Movies::StarWars.specie, Faker::Movies::StarWars.vehicle, Faker::Movies::StarWars.droid].sample} #{['available', 'for hire', 'for rent'].sample}",
    price: rand(1..100_00),
    description: "#{Faker::Movies::StarWars.quote}. #{Faker::Movies::StarWars.quote}. #{Faker::Movies::StarWars.quote}",
    address: location.address
  )
  offer.latitude = location.longitude
  offer.longitude = location.latitude
  offer.photo.attach(io: file, filename: "new#{rand(1..111_111_111)}.png")
  offer.user = rand_user
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
    start_date: Date.new(2001, 2, 3),
    end_date: Date.new(2003, 2, 3)
  )

  book.user = rand_user
  book.offer = rand_offer
  book.save!
  puts book.user_message
end
