class MapBoundaryError < RuntimeError
end
class MapCollisionError < RuntimeError
end

def distance(x1, y1, x2, y2)
  dx = (x2 - x1);
  dy = (y2 - y1);
  dist = dx * dx + dy * dy;
end

class Map
  attr_reader :height, :width, :map
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

    pos(entity, x, y)
  end

  def pos(entity, x, y)

    # bounds checking
    if x >= @width || x < 0
      raise MapBoundaryError.new("x out of bounds")
    end
    if y >= @height || y < 0
      raise MapBoundaryError.new("y out of bounds")
    end

    # collision detection
    if @map[x][y] && @map[x][y] != entity
      raise MapCollisionError.new("#{entity.id} moved to collide with #{@map[x][y].id}")
    end

    if entity.on_map?
      @map[entity.x][entity.y] = nil
    end

    @map[x][y] = entity
    entity.pos(x, y)

    return true
  end

  def turn
    @entities.each do |entity|
      entity.turn()
    end
  end


  def to_s
    s = "\n"

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

