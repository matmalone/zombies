class Entity
  attr_reader :id, :x, :y, :is_killed
  def initialize(id, map, opts = {})
    @id = id
    @opts = opts
    @char = @opts[:char]
    @map = map
    @x = @y = nil
    @is_killed = false
  end

  def char
    @char || 'E'
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

  def kill()
    @is_killed = true
    @char = 'K'
  end

  def dbg(msg)
    puts "#{@id}: #{msg}\n"
  end

def move(gravity_x, gravity_y)
  # dead people don't move!
  if is_killed then return end

  delta_x = gravity_x != 0 ? gravity_x / gravity_x.abs : 0
  delta_y = gravity_y != 0 ? gravity_y / gravity_y.abs : 0

  new_x = delta_x + @x
  new_y = delta_y + @y

  # collision detection
  if @map.grid[new_x][new_y] then return false end

  # boundary detection
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
  def initialize(id, map, opts = {})
    super
    @char ||= 'Z'
  end

  def turn()
    super
    # get the list of neighbors
    condemned = @map.neighbors(x, y).
      # but just the living humans
      select { |neighbor| neighbor.is_a?(Human) && !neighbor.is_killed }.
      # pick 1 at random
      sample(ZOMBIE_KILLER_PER_TICK).
      # and kill him
      each { |h| h.kill }

    target = nil
    target_dist = Fixnum.max

    for y in 0..(@map.width - 1)
      for x in 0..(@map.height - 1)
        neighbor = @map.grid[x][y]
        if neighbor.is_a?(Human) && !neighbor.is_killed
          bandit = @map.grid[x][y]
          dist = distance(x, y, @x, @y)
          # dbg("found #{bandit.id} at [#{x}][#{y}] distance #{dist}")
          if dist < target_dist
            target = bandit
            target_dist = dist
          end
        end
      end
    end

    if target
      # dbg("targeting #{target.id} at [#{target.x}][#{target.y}] distance #{  target_dist}")

      gravity_x = target.x - @x
      gravity_y = target.y - @y
      move(gravity_x, gravity_y)
    end
  end
end

class Human < Entity
  def initialize(id, map, opts = {})
    super
    @char ||= 'H'
  end

  def turn()
    super
    if @is_killed then turn_dead
    else turn_living end
  end

  def turn_dead
    @turn_timer -= 1
    if @turn_timer <= 0
      # turn into a zombie
      @map.delete(@x, @y) # delete reference to myself
      @map.add(Zombie.new(:turned, @map), @x, @y) # create a new zombie at our current position
    end
  end
  def turn_living
    gravity_x = gravity_y = 0

    for y in 0..(@map.width - 1)
      for x in 0..(@map.height - 1)
        if @map.grid[x][y].is_a? Zombie
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

  def kill
    super
    @turn_timer = rand(10)
  end
end




