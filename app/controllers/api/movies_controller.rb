class Api::MoviesController < Api::BaseController

  before_filter :getMovie, :except => [:index, :create]
  respond_to :json
  def index
    @MovieCount = Movie.count
    response.headers['X-Total-Count'] = @MovieCount.size.to_s

    @pageInput = params[:page]
    @perPageInput = params[:per_page]
    @Movies = Movie.includes(:genres).paginate(:page => params[:page], :per_page => params[:per_page])
    response.headers['Link'] = createLink(@MovieCount, 1, "/api/movies/", @pageInput.to_i, @perPageInput.to_i)
    render :json => @Movies.to_json(include: :genres)
  end

  def show
    render :json => getMovie.to_json(include: :genres)
  end

  # POST /genres
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      @movieGenres = params[:genres]
      @movieGenres.each do |movieGenre|
        temp = MovieGenre.new(movie_id: @movie.id, genre_id: movieGenre[:id])
        temp.save
      end
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres
  def update
    @movieId.update_attributes!(movie_params)
    render json: @movieId
  end

  # DELETE /genres
  def destroy
    @movieId.destroy
    head :no_content
  end

  def getMovie
    @movieId ||= Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :director, genres_attributes: [:id, :name])
  end

  def moviegenre_params
    params.require(:moviegenre).permit(:movie_id, :genre_id)
  end

end
