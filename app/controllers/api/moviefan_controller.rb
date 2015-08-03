class Api::MoviefanController < Api::BaseController
  before_filter :set_current_user
  respond_to :json
  def index
    @current_user = User.current
    render json: @current_user.movies
  end

  def create
    @userId = User.current.id
    @movieId = params[:movieId]
    @moviefan = MovieFan.new(movie_id: @movieId, user_id: @userId)
    @moviefan.save
    render json: @moviefan
  end

  def destroy
    @userId = User.current.id
    @movieId = params[:id]
    @moviefan = MovieFan.delete_all(movie_id: @movieId, user_id: @userId)
    render :nothing => true, :status => 200
    #head :no_content
  end

end
