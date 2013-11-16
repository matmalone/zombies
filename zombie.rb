class Entity
    def initialize(id, opts = {})
        @id = id
        @opts = opts
        @opts[:char] ||= 'E'
    end

    def char
        return @opts[:char]
    end

    def pos(x, y)
        @x = x
        @y = y
    end

    def turn(map)
        dbg("i am at #{@x}:#{@y}")
    end

    def dbg(msg)
        puts "#{@id}: #{msg}\n"
    end

end

class Zombie < Entity
end

class Human < Entity
    def turn(map)
        super

        heat_south = heat_north = heat_west = heat_east = 0

        for y in 0..(map.width - 1)
            for x in 0..(map.height - 1)
                if map.map[x][y].is_a? Zombie
                    dbg("#{@id}: found zombie at [#{x}][#{y}]")
                    if x < @x
                        heat_west += 1
                    elsif x > @x
                        heat_east += 1
                    end
                    if y < @y
                        heat_south += 1
                    elsif y > @y
                        heat_north += 1
                    end
                end
            end
        end
        dbg("heat_east: #{heat_east}, heat_west: #{heat_west}, heat_south: #{heat_south}, heat_north: #{heat_north}")


    end    
end




