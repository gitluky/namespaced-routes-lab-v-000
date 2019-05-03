class Preference < ActiveRecord::Base

  def sort_artist(artists)
    if self.artist_sort_order == "DESC"
      artists.sort_by { |artist| -artist.name }
    else
      self.artists.sort_by {|artist| artist.name }
    end
  end

  def sort_song(songs)
    if self.song_sort_order == "DESC"
      songs.sort_by { |song| -song.name }
    else
      self.songs.sort_by {|song| song.name }
    end
  end

end
