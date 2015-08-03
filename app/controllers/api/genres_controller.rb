class Api::GenresController < Api::BaseController
  before_filter :getGenre, :except => [:index, :create]

  respond_to :json

  def index
    @GenreCount = Genre.count
    response.headers['X-Total-Count'] = @GenreCount.size.to_s

    @pageInput = params[:page]
    @perPageInput = params[:per_page]
    @Genres = Genre.paginate(:page => params[:page], :per_page => params[:per_page])
    response.headers['Link'] = createLink(@GenreCount, 1, "/api/genres/", @pageInput.to_i, @perPageInput.to_i)
    render json: Genre.all
  end

  def show
    render :json => getGenre.to_json()
  end
  # POST /genres
  def create
    @genre = Genre.new(genres_params)
    if @genre.save
      render json: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres
  def update
    @genreId.update_attributes!(genres_params)
    render json: @genreId
  end

  # DELETE /genres
  def destroy
    @genreId.destroy
    head :no_content
  end

  def getGenre
    @genreId ||= Genre.find(params[:id])
  end

  def genres_params
    params[:genre].permit(:name)
  end
end
