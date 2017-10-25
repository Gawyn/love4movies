# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(
  email: 'foonian@foo.com',
  password: 'barfoo',
  name: 'Foonian',
  nickname: 'foonian'
)

MovieSearcher.new.perform('Chungking Express')

Rating.create(
  user: user,
  movie: Movie.first,
  value: 9
)
