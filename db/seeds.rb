# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  email: 'testuser@love4movies.com',
  password: 'batmanLove66'
)

MovieSearcher.new.perform('Chungking Express') if Movie.count == 0

Rating.create(
  movie_id: Movie.first.id,
  user_id: User.first.id,
  value: 8
)
