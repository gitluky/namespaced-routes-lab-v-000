class ArtistsController < ApplicationController
  def index
    preference = Preference.last
    @artists = Artist.all
    if !preference.nil?
      @artists = sort_artists(preference, @artist)
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    preference = Preference.last
    if preference.allow_create_artists
      @artist = Artist.new
    else
      redirect_to artists_path
    end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def sort_artists(preference, artists)
    if preference.artist_sort_order == "DESC"
      artists.sort_by { |artist| -artist.name }
    else
      preference.artists.sort_by {|artist| artist.name }
    end
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
