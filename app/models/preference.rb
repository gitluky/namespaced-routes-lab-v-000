class Preference < ActiveRecord::Base

  def sort_artist(preference, artists)
    if self.artist_sort_order == "DESC"
      artists.sort_by { |artist| -artist.name }
    else
      self.artists.sort_by {|artist| artist.name }
    end
  end

end
