#!/usr/bin/ruby

require_relative 'map'
require_relative 'zombie'
require_relative 'util'

puts "Welcome to zombies!\n"

map = Map.new(30, 30)

zombie1 = Zombie.new(:zombie1, map)
zombie2 = Zombie.new(:zombie2, map)
zombie3 = Zombie.new(:zombie3, map)

human1 = Human.new(:human1, map, {:char => '1'})
human2 = Human.new(:human2, map, {:char => '2'})

map.add(zombie1, 2, 0)
map.add(zombie2, 20, 10)
map.add(zombie3, 9, 4)

map.add(human1, 2, 8)
map.add(human2, 5, 6)

(0..100).each do |i|
  puts map
  map.turn
  sleep(0.1)
end
