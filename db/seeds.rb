# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts 'Cleaning up database..'
Movie.destroy_all

url = 'https://tmdb.lewagon.com/movie/top_rated'
result = URI.open(url).read
hash = JSON.parse(result)
results = hash['results']
results[0..9].each do |object|
  Movie.create(title: object['title'], overview: object['overview'], poster_url: "https://image.tmdb.org/t/p/original#{object['poster_path']}", rating: object['vote_average'])
end

puts 'done!'
