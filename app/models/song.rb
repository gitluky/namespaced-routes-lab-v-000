class Song < ActiveRecord::Base
  belongs_to :artist

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    if !params[:artist_name].blank?
      artist = Artist.find_or_create_by(name: name)
      self.artist = artist
    end
  end

  def sort_songs(preference, songs)
    if preference.song_sort_order == "DESC"
      songs.sort_by { |song| -song.name }
    else
      preference.songs.sort_by {|song| song.name }
    end
  end

end
