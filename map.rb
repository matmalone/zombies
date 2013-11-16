class MapBoundaryError < RuntimeError
end

class Map
  attr_accessor :height, :width, :map
  def initialize(height, width)
    @height = height
    @width = width
    @map = []

    # init map
    (0..@width).each do |x|
      @map[x] = []
    end

    @entities = []
  end

  def add(entity, x, y)
    @entities << entity

    # bounds checking
    if x >= @width || x < 0
      raise MapBoundaryError.new("x out of bounds")
    end
    if y >= @height || y < 0
      raise MapBoundaryError.new("y out of bounds")
    end

    @map[x][y] = entity
    entity.pos(x, y)

    return true
  end

  def turn
    @entities.each do |entity|
      entity.turn(self)
    end
  end


  def to_s
    s = ''

    for y in (@height - 1).downto(0)
      for x in 0..(@width - 1)
        if @map[x][y]
          s += @map[x][y].char
        else 
          s += "."
        end
      end
      s = s + "\n"
    end

    return s
  end
end

