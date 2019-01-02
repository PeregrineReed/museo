class Photograph

  attr_reader :id,
              :name,
              :artist_id

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @artist_id = attributes[:artist_id]
  end

end
