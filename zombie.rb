class Entity
  attr_reader :id, :x, :y
  def initialize(id, map, opts = {})
    @id = id
    @opts = opts
    @opts[:char] ||= 'E'
    @map = map
    @x = @y = nil
  end

  def char
    return @opts[:char]
  end

  def on_map?
    return x != nil
  end

  def pos(x, y)
    @x = x
    @y = y
  end

  def turn()
    # dbg("i am at #{@x}:#{@y}")
  end

  def dbg(msg)
    puts "#{@id}: #{msg}\n"
  end

def move(gravity_x, gravity_y)
    delta_x = gravity_x != 0 ? gravity_x / gravity_x.abs : 0
    delta_y = gravity_y != 0 ? gravity_y / gravity_y.abs : 0

    new_x = delta_x + @x
    new_y = delta_y + @y

    if new_x > @map.width - 1
      new_x = @map.width - 1
    end
    if new_x < 0
      new_x = 0
    end
    if new_y > @map.height - 1
      new_y = @map.height - 1
    end
    if new_y < 0
      new_y = 0
    end

    @map.pos(self, new_x, new_y)
  end
end

class Zombie < Entity
  def turn()
    super

    target = nil
    target_dist = Fixnum.max

    for y in 0..(@map.width - 1)
      for x in 0..(@map.height - 1)
        if @map.map[x][y].is_a? Human
          bandit = @map.map[x][y]
          dist = distance(x, y, @x, @y)
          # dbg("found #{bandit.id} at [#{x}][#{y}] distance #{dist}")
          if dist < target_dist
            target = bandit
            target_dist = dist
          end
        end
      end
    end

    dbg("targeting #{target.id} at [#{target.x}][#{target.y}] distance #{  target_dist}")

    # move(gravity_x, gravity_y)
  end
end

class Human < Entity
  def turn()
    super

    gravity_x = gravity_y = 0

    for y in 0..(@map.width - 1)
      for x in 0..(@map.height - 1)
        if @map.map[x][y].is_a? Zombie
          if x < @x
            gravity_x += 1
          elsif x > @x
            gravity_x -= 1
          end
          if y < @y
            gravity_y += 1
          elsif y > @y
            gravity_y -= 1
          end
        end
      end
    end

    move(gravity_x, gravity_y)
  end
end




