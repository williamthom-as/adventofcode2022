str = File.read('day9/source.txt')
arr = str.split("\n")

knots = Array.new(10) { { x: 0, y: 0 } }
knots_history = []

calc_head = {
  'R' => proc { |coord| coord[:x] += 1 },
  'L' => proc { |coord| coord[:x] -= 1 },
  'U' => proc { |coord| coord[:y] += 1 },
  'D' => proc { |coord| coord[:y] -= 1 }
}

calc_knot = proc do |idx, p_knots|
  prev_knot, next_knot = p_knots[idx - 1..idx]
  distance = { x: (prev_knot[:x] - next_knot[:x]), y: (prev_knot[:y] - next_knot[:y]) }
  length = (distance[:x].abs + distance[:y].abs).to_f

  if length.zero?
    nil
  else
    distance[:x] = (distance[:x] / length).round
    distance[:y] = (distance[:y] / length).round
    { x: prev_knot[:x] - distance[:x], y: prev_knot[:y] - distance[:y] }
  end
end

# store_elem = 1 # solution 1
store_elem = 9 # solution 2

arr.each do |cmd|
  cmds = cmd.split(' ')
  distance = cmds[1].to_i

  1.upto(distance) do
    calc_head[cmds[0]].call(knots[0])
    1.upto(knots.size - 1) do |idx|
      new_knot = calc_knot.call(idx, knots)
      knots[idx] = new_knot if new_knot
    end

    # Store only the tail position
    knots_history << knots[store_elem]
  end
end

p knots_history.uniq.size

