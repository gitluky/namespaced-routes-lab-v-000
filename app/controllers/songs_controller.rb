class SongsController < ApplicationController
  def index
    preference = Preference.last
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
    if !preference.nil?
      @songs = sort_songs(preference, @songs)
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    preference = Preference.last
    if !preference.nil?
      if preference.allow_create_songs
        @song = Song.new(artist_id: params[:artist_id])
      else
        redirect_to songs_path
      end
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def sort_songs(preference, songs)
    if preference.song_sort_order == "DESC"
      songs.sort_by { |song| -song.title }
    else
      preference.songs.sort_by {|song| song.title }
    end
  end

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end
