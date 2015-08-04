# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Genre.delete_all
@crime = Genre.create(name: 'crime')
@drama = Genre.create(name: 'drama')
@sports = Genre.create(name: 'sports')
@comedy = Genre.create(name: 'comedy')

Movie.delete_all
@shawshank = Movie.create(title: 'The Shawshank Redemption', rating: '9.3', director: 'Frank Darabont')
@godfather = Movie.create(title: 'The Godfather', rating: '9.2', director: 'Francis Ford Coppola')
@rocky = Movie.create(title: 'Rocky Balboa', rating: '7.2', director: 'Sylvester Stallone')

MovieGenre.delete_all
MovieGenre.create(movie_id: @shawshank.id, genre_id: @crime.id)
MovieGenre.create(movie_id: @shawshank.id, genre_id: @drama.id)
MovieGenre.create(movie_id: @godfather.id, genre_id: @crime.id)
MovieGenre.create(movie_id: @godfather.id, genre_id: @drama.id)
MovieGenre.create(movie_id: @rocky.id, genre_id: @drama.id)
MovieGenre.create(movie_id: @rocky.id, genre_id: @sports.id)

User.delete_all
@adminUser = User.create! :email => 'admin@admin.com', :password => 'admin', :password_confirmation => 'admin', :langKey => 'en', :username => 'admin'
@user = User.create! :email => 'user@user.com', :password => 'user', :password_confirmation => 'user', :langKey => 'en', :username => 'user'

UsersRole.delete_all
UsersRole.create(roleName: 'ROLE_ADMIN', user_id: @adminUser.id)
UsersRole.create(roleName: 'ROLE_USER', user_id: @adminUser.id)
UsersRole.create(roleName: 'ROLE_USER', user_id: @user.id)



