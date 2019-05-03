class Preference < ActiveRecord::Base

  def sort_artist(preference, artists)
    if preference.artist_sort_order == "DESC"
      artists.sort_by { |artist| -artist.name }
    else
      preference.artists.sort_by {|artist| artist.name }
    end
  end

  def sort_song(preference, songs)
    if preference.song_sort_order == "DESC"
      songs.sort_by { |song| -song.name }
    else
      preference.songs.sort_by {|song| song.name }
    end
  end

end
