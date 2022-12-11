# frozen_string_literal: true
#
str = File.read('day10/source.txt')

magic_values = []
operations = []

# Make instruction list
ops = str.split("\n")
ops.each do |op|
  if op.start_with? 'noop'
    operations << nil
  elsif op.start_with? 'addx'
    _name, amount = op.split(' ')
    operations << nil
    operations << [:add, amount.to_i]
  end
end

# Execute instruction cycles
x_reg = 1
pixels = []
white_space_char = ' '
operations.each_with_index do |operation, idx|
  cycle_cnt = idx + 1

  if [20, 60, 100, 140, 180, 220].include? cycle_cnt
    signal_str = cycle_cnt * x_reg
    magic_values << signal_str
    puts "Part 1: #{magic_values.sum}" if cycle_cnt == 220
  end

  pixel = white_space_char
  pixel = '#' if [x_reg - 1, x_reg, x_reg + 1].include?((cycle_cnt - 1) % 40)
  pixels << pixel
  pixels << "\n" if (cycle_cnt % 40).zero?

  next unless operation

  x_reg += operation[1] if operation[0] == :add
end

puts 'Part 2:'
puts pixels.join('')
