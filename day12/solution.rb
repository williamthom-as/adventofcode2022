# frozen_string_literal: true

class MatrixMaze

  def initialize(maze)
    @maze = maze
    @current_position = nil # [row, column]
    @rows_cnt = @maze.length
    @columns_cnt = @maze[0].length
  end

  def calc_distances
    init_height_map

    queue = [@start_position]
    visited = []
    total = nil
    x = 0

    while queue.length.positive?
      current_pos = queue.pop
      visited.append(current_pos)

      next_positions = next_positions(current_pos)

      if next_positions.include?(@end_position)
        total = @distances[current_pos] + 1
        puts total
        queue = []
      end

      next_positions.each do |next_pos|
        @distances[next_pos] = [@distances[next_pos], @distances[current_pos] + 1].min

        if !visited.include?(next_pos) && !queue.include?(next_pos)
          puts next_pos.inspect
          queue.append(next_pos)
        end
      end
    end

    total
  end

  private

  def init_height_map
    @distances = {}
    max = 2**32

    @maze.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        if col == 'S'
          @start_position = [row_idx, col_idx]
          @distances[@start_position] = 0
          next
        end

        @end_position = [row_idx, col_idx] if col == 'E'
        @distances[[row_idx, col_idx]] = max
      end
    end
  end

  def next_positions(position)
    result = []
    l = [position[0], position[1] - 1]
    result << l if can_visit?(position, l)

    r = [position[0], position[1] + 1]
    result << r if can_visit?(position, r)

    t = [position[0] - 1, position[1]]
    result << t if can_visit?(position, t)

    b = [position[0] + 1, position[1]]
    result << b if can_visit?(position, b)

    result
  end

  def can_visit?(current_pos, visit_pos)
    return false if (visit_pos[0]).negative? || visit_pos[0] > @maze.size - 1
    return false if (visit_pos[1]).negative? || visit_pos[1] > @maze[0].size - 1

    current_height = @maze[current_pos[0]][current_pos[1]]
    visit_height = @maze[visit_pos[0]][visit_pos[1]]

    height_diff = all_heights.find_index(visit_height) - all_heights.find_index(current_height)
    height_diff <= 1
  end

  def all_heights
    @all_heights ||= ['S'] + ('a'..'z').to_a + ['E']
  end
end

str = File.read('day12/text.txt')
maze_arrs = str.split("\n").map { |x| x.split('') }

maze = MatrixMaze.new(maze_arrs)
puts maze.calc_distances



