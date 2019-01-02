class Artist

  attr_reader :id,
              :name,
              :born,
              :died

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @born = attributes[:born]
    @died = attributes[:died]
  end

end
