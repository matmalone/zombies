#!/usr/bin/ruby

require_relative 'map'
require_relative 'zombie'

puts "Welcome to zombies!\n"

map = Map.new(10, 10)

zombie1 = Zombie.new(:zombie1, {:char => 'Z'})
zombie2 = Zombie.new(:zombie2, {:char => 'Z'})

human1 = Human.new(:human1, {:char => 'H'})

map.add(zombie1, 0, 0)
map.add(zombie2, 1, 9)

map.add(human1, 6, 7)

puts map

map.turn
