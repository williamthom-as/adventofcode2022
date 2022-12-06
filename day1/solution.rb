# frozen_string_literal: true

str = File.read("day1/source.txt")

max_count = 0
max_index_at = 0

counts = []
tokens = str.split("\n\n")
tokens.each_with_index do |token, idx|
  vals = token.split("\n")
  counts << vals.sum(&:to_i)

  # if max_count < total
  #   max_count = total
  #   max_index_at = idx
  #
  #   puts max_count, max_index_at
  # end
end

# puts max_count, max_index_at # Sol 1
# puts counts.sort.reverse.take(3).sum # Sol 2