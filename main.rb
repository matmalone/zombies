#!/usr/bin/ruby

require_relative 'map'
require_relative 'zombie'

puts "Welcome to zombies!\n"

map = Map.new(10, 10)

zombie1 = Zombie.new(:zombie1, map, {:char => 'Z'})
zombie2 = Zombie.new(:zombie2, map, {:char => 'Z'})

human1 = Human.new(:human1, map, {:char => 'H'})

map.add(zombie1, 0, 0)
map.add(zombie2, 1, 2)

map.add(human1, 8, 4)

(0..10).each do |i|
  puts map
  map.turn
  sleep(1)
end
