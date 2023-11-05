# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
seed = 42
Faker::Config.random = Random.new(seed)
rng = Random.new(seed)

5.times do
  brand = Brand.create(name: Faker::Vehicle.manufacture, year: Faker::Vehicle.year)

  10.times do
    Car.create(seats: rng.rand(1..5), model: Faker::Vehicle.model, price: rng.rand(10000..50000), brand_id: brand.id )
  end
end
