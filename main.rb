#!/usr/bin/ruby

require_relative 'map'
require_relative 'zombie'
require_relative 'util'

puts "Welcome to zombies!\n"

map = Map.new(10, 10)

zombie1 = Zombie.new(:zombie1, map, {:char => 'Z'})
zombie2 = Zombie.new(:zombie2, map, {:char => 'Z'})

human1 = Human.new(:human1, map, {:char => '1'})
human2 = Human.new(:human2, map, {:char => '2'})

map.add(zombie1, 3, 0)
map.add(zombie2, 4, 2)

map.add(human1, 2, 4)
map.add(human2, 5, 3)

(0..10).each do |i|
  puts map
  map.turn
  sleep(1)
end
