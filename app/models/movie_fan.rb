class MovieFan < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  attr_accessible :movie_id, :user_id
end
