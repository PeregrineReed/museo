class Artist

  attr_reader :id,
              :name,
              :born

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @born = attributes[:born]
  end

end
