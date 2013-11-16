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

        heat_down = heat_up = heat_left = heat_right = 0

        for y in 0..(map.width - 1)
            for x in 0..(map.height - 1)
                if map.map[x][y].is_a? Zombie
                    dbg("#{@id}: found zombie at [#{x}][#{y}]")
                    if x < @x
                        heat_left += 1
                    elsif x > @x
                        heat_right += 1
                    end
                    if y < @y
                        heat_down += 1
                    elsif y > @y
                        heat_up += 1
                    end
                end
            end
        end
        dbg("heat_right: #{heat_right}, heat_left: #{heat_left}, heat_down: #{heat_down}, heat_up: #{heat_up}")

    end    
end




