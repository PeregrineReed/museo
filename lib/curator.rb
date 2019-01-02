class Curator

  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    photographs << photo
  end

  def add_artist(artist)
    artists << artist
  end

  def find_artist_by_id(id)
    artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    photographs.find do |photo|
      photo.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.reject do |artist|
      find_photographs_by_artist(artist).size <= 1
    end
  end

  def artists_from(country)
    @artists.reject do |artist|
      artist.country != country
    end
  end

  def photographs_taken_by_artist_from(country)
    artists_from(country).map do |artist|
      find_photographs_by_artist(artist)
    end.flatten
  end

end
