class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
        if @genre.save
            redirect_to admin_genres_path#(@genre)は、idを指定する時に記述するので不要
        else
            render :index
        end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
        @genre = Genre.find(params[:id])
        if @genre.update(genre_params)
            flash[:notice] = "You have updated genre successfully."
            redirect_to admin_genres_path(@genre)
        else
            render :edit
        end
  end

  private
  def genre_params
      params.require(:genre).permit(:name)
  end
end
