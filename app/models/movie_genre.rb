class MovieGenre < ActiveRecord::Base
  belongs_to :movie
  belongs_to :genre

  attr_accessible :movie_id, :genre_id

end
