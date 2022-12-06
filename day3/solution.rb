# frozen_string_literal: true

str = File.read('day3/source.txt')

# Solution 1
dupes_count = 0
tokens = str.split("\n")
a_to_z_range = ('a'..'z').to_a + ('A'..'Z').to_a

tokens.each do |token|
  length = token.length
  first_compartment = token[0..((length / 2) - 1)].to_s
  second_compartment = token[(length / 2)..].to_s

  result = first_compartment.chars.sort & second_compartment.chars.sort
  dupes_count += a_to_z_range.find_index(result.first) + 1 unless result.empty?
end

puts "Result: #{dupes_count}"

# Solution 2
badge_count = 0
tokens = str.split("\n")
a_to_z_range = ('a'..'z').to_a + ('A'..'Z').to_a

tokens.each_slice(3).each do |token_list|
  union = token_list.map(&:chars).inject { |exist, u| exist & u }
  badge_count += a_to_z_range.find_index(union.first) + 1
end

puts "Result: #{badge_count}"
