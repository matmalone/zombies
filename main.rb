#!/usr/bin/ruby

require_relative 'map'
require_relative 'zombie'
require_relative 'util'

ZOMBIE_KILLER_PER_TICK = 1

puts "Welcome to zombies!\n"

map = Map.new(60, 38)

zombie1 = Zombie.new(:zombie1, map)
zombie2 = Zombie.new(:zombie2, map)
zombie3 = Zombie.new(:zombie3, map)

human1 = Human.new(:human1, map, {:char => '1'})
human2 = Human.new(:human2, map, {:char => '2'})

map.add(zombie1, 10, 0)
map.add(zombie2, 10, 1)
map.add(zombie3, 10, 37)

map.add(human1, 11, 10)
# map.add(human2, 5, 0)

(0..100).each do |i|
  puts map
  map.turn
  sleep(0.1)
end
