class Movie < ActiveRecord::Base
  has_many :movie_genres, inverse_of: :movie
  has_many :genres, :through => :movie_genres
end
