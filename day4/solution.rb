# frozen_string_literal: true

str = File.read('day4/source.txt')
tokens = str.split("\n")
overlap = 0

tokens.each do |token|
  values = token.split(',').map { |v| v.split('-').each_slice(2).map { |f, s| f.to_i..s.to_i }.first }
  overlap += 1 if values.first&.member?(values.last) || values.last&.member?(values.first) # solution 1
  # overlap += 1 if values.last.begin <= values.first.end && values.first.begin <= values.last.end # solution 2
end

puts "Result: #{overlap}"
