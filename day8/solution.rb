# frozen_string_literal: true

class Forest

  attr_reader :visible, :not_visible

  def initialize(forest)
    @forest = forest
    @visible = 0
    @not_visible = 0
  end

  def calculate_visible
    0.upto(last_row) do |row_idx|
      # If first or last row - all the columns are visible
      if [0, last_row].include?(row_idx)
        @visible += @forest[row_idx].size
        next
      end

      0.upto(last_column) do |col_idx|
        if [0, last_column].include?(col_idx)
          @visible += 1
          next
        end

        is_visible?(row_idx, col_idx) ? @visible += 1 : @not_visible += 1
      end
    end
  end

  def calculate_scenic_score
    current_max = 0
    0.upto(last_row) do |row_idx|
      # If first or last row - all the columns are visible
      next if [0, last_row].include?(row_idx)

      0.upto(last_column) do |col_idx|
        next if [0, last_column].include?(col_idx)

        tree_score = scenic_score(row_idx, col_idx)
        current_max = tree_score if tree_score > current_max
      end
    end

    current_max
  end

  # @return [TrueClass,FalseClass]
  # @param [Integer] row_idx
  # @param [Integer] col_idx
  def is_visible?(row_idx, col_idx)
    current_value = @forest[row_idx][col_idx].to_i

    current_row = @forest[row_idx]
    return true if current_row[0..(col_idx - 1)].map(&:to_i).max < current_value # Check left
    return true if current_row[(col_idx + 1)..].map(&:to_i).max < current_value # Check right

    current_cols = @forest.map { |c| c[col_idx] }
    return true if current_cols[0..(row_idx - 1)].map(&:to_i).max < current_value
    return true if current_cols[(row_idx + 1)..].map(&:to_i).max < current_value

    false
  end

  # @return [Integer]
  # @param [Integer] row_idx
  # @param [Integer] col_idx
  def scenic_score(row_idx, col_idx)
    current_value = @forest[row_idx][col_idx].to_i
    current_row = @forest[row_idx]

    left_score = 0
    current_row[0..(col_idx - 1)].reverse_each do |v|
      left_score += 1
      break unless v.to_i < current_value
    end

    right_score = 0
    current_row[(col_idx + 1)..].each do |v|
      right_score += 1
      break unless v.to_i < current_value
    end

    current_cols = @forest.map { |c| c[col_idx] }

    up_score = 0
    current_cols[0..(row_idx - 1)].reverse_each do |v|
      up_score += 1
      break unless v.to_i < current_value
    end

    down_score = 0
    current_cols[(row_idx + 1)..].each do |v|
      down_score += 1
      break unless v.to_i < current_value
    end

    left_score * right_score * down_score * up_score
  end

  def last_row
    @forest.size - 1
  end

  def last_column
    @forest[0].size - 1
  end
end

str = File.read('day8/source.txt')
str.split("\n")
forest_arr = str.split("\n").map { |n| n.split('') }

f = Forest.new(forest_arr)
f.calculate_visible

puts "Visible: #{f.visible}"
puts "Not visible: #{f.not_visible}"

puts f.calculate_scenic_score