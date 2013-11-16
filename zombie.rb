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
    dbg("i am at #{@x}:#{@y}")
  end

  def dbg(msg)
    # puts "#{@id}: #{msg}\n"
  end

end

class Zombie < Entity
end

class Human < Entity
  def turn()
    super

    gravity_x = gravity_y = 0

    for y in 0..(@map.width - 1)
      for x in 0..(@map.height - 1)
        if @map.map[x][y].is_a? Zombie
          dbg("#{@id}: found zombie at [#{x}][#{y}]")
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
    dbg("gravity_x: #{gravity_x}, gravity_y: #{gravity_y}")

    delta_x = gravity_x != 0 ? gravity_x / gravity_x.abs : 0
    delta_y = gravity_y != 0 ? gravity_y / gravity_y.abs : 0

    dbg("delta_x: #{delta_x}, delta_y: #{delta_y}")

    new_x = delta_x + @x
    new_y = delta_y + @y

    if new_x > @map.width - 1
      new_x = @map.width - 1
    end
    if new_y > @map.height - 1
      new_y > @map.height - 1
    end

    @map.move(self, new_x, new_y)
  end

end




