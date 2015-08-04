# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Genre.delete_all
Genre.create(name: 'crime')
Genre.create(name: 'drama')
Genre.create(name: 'sports')
Genre.create(name: 'comedy')

Movie.delete_all
Movie.create(title: 'The Shawshank Redemption', rating: '9.3', director: 'Frank Darabont')
Movie.create(title: 'The Godfather', rating: '9.2', director: 'Francis Ford Coppola')
Movie.create(title: 'Rocky Balboa', rating: '7.2', director: 'Sylvester Stallone')

MovieGenre.delete_all
MovieGenre.create(movie_id: 1, genre_id: 1)
MovieGenre.create(movie_id: 1, genre_id: 2)
MovieGenre.create(movie_id: 2, genre_id: 1)
MovieGenre.create(movie_id: 2, genre_id: 2)
MovieGenre.create(movie_id: 3, genre_id: 2)
MovieGenre.create(movie_id: 3, genre_id: 3)

User.delete_all
@adminUser = User.create(email: 'user@user.com', encrypted_password: '$2a$10$h0mYUbnXJLppnAuLmjEi2eFpcPNOgy9TwB6jMAT4Elf2Zzg0qnhue', username: "user")
@user = User.create(email: 'admin@admin.com', encrypted_password: '$2a$10$q7KlPraTz4VRBoyE9vlyQOXn7FRkxunZi0XE8wU3IAbS7MJQiAigW', username: "admin")

UsersRole.delete_all
UsersRole.create(roleName: 'ROLE_ADMIN', user_id: @adminUser.id)
UsersRole.create(roleName: 'ROLE_USER', user_id: @adminUser.id)
UsersRole.create(roleName: 'ROLE_USER', user_id: @user.id)