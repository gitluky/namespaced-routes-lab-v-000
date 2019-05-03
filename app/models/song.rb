class Song < ActiveRecord::Base
  validates :artist_id, :allow_nil => true
  belongs_to :artist, :presence => false

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    if !name.blank?
      artist = Artist.find_or_create_by(name: name)
      self.artist = artist
    end
  end

end
