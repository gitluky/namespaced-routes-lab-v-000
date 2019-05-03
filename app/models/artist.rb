class Artist < ActiveRecord::Base
  has_many :songs

  def sort_artists(preference, artists)
    if preference.artist_sort_order == "DESC"
      artists.sort_by { |artist| -artist.name }
    else
      preference.artists.sort_by {|artist| artist.name }
    end
  end

end
