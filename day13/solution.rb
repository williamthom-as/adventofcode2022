# frozen_string_literal: true

require 'json'

def in_order?(first_val, last_val)
  if first_val == [] && last_val == []
    0
  elsif first_val.instance_of?(Array) && last_val.instance_of?(Array)
    result = nil
    [first_val.length, last_val.length].max.times do |idx|
      first = first_val[idx]
      last = last_val[idx]
      result = in_order?(first, last)
      break if result != 0
    end

    result
  elsif first_val.instance_of?(Integer) && last_val.instance_of?(Integer)
    first_val <=> last_val
  elsif first_val.instance_of?(Array) && last_val.instance_of?(Integer)
    in_order?(first_val, [last_val])
  elsif first_val.instance_of?(Integer) && last_val.instance_of?(Array)
    in_order?([first_val], last_val)
  elsif first_val.nil? && [Integer, Array].include?(last_val.class)
    -1
  elsif [Integer, Array].include?(first_val.class) && last_val.nil?
    1
  else
    p "here - #{first_val}/#{last_val}"
    raise
  end
end

str = File.read('day13/source.txt')
signals = str.split("\n\n")

# part 1
ordered_signals = []
signals.each_with_index do |signal, s_idx|
  s_idx += 1
  puts "== Pair #{s_idx} =="

  packets = signal.split("\n")

  first = JSON.parse(packets[0])
  last = JSON.parse(packets[1])

  result = in_order?(first, last)
  if !result.nil? && result.negative?
    puts '... included'
    ordered_signals << s_idx
  else
    puts '... excluded'
  end
end

puts "Signals: #{ordered_signals.sum}"

## part 2
lines = "#{str}\n\n[[2]]\n\n[[6]]".split("\n\n")
                                  .map { |s| s.split("\n") }
                                  .flatten
                                  .map { |e| JSON.parse(e) }

lines = lines.sort { |a, b| in_order?(a, b) }
puts "Part 2: #{(lines.find_index([[2]]) + 1) * (lines.find_index([[6]]) + 1)}"
