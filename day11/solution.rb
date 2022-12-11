# frozen_string_literal: true

monkeys = []

# Parse
str = File.read('day11/source.txt')
str.split("\n\n").each do |definition|
  monkey = {}
  definition.split("\n").each do |rules|
    if rules.strip.start_with?('Starting')
      monkey[:items] = rules.split(':').last.split(',').map { |r| r.strip.to_i }
      next
    elsif rules.strip.start_with?('Operation')
      monkey[:operation] = rules.split(':').last.strip
    elsif rules.strip.start_with?('Test')
      monkey[:test] = {
        operation: rules.split(':').last.strip.split(' ').last.to_i,
        true_outcome: '',
        false_outcome: ''
      }
    elsif rules.strip.start_with?('If')
      tokens = rules.strip.split(':')
      type = tokens.first.gsub('If ', '')
      monkey[:test]["#{type}_outcome".to_sym] = tokens.last.split(' ').last.to_i
    end
  end

  monkeys << monkey
end

# Rounds
inspects = {}
mod = monkeys.map { |m| m[:test][:operation] }.inject(:*)

1.upto(10_000) do
  monkeys.each_with_index do |monkey, idx|
    inspects[idx] = 0 unless inspects.key? idx

    changes = []
    monkey[:items].each do |item|
      inspects[idx] += 1

      old = item # allow eval to resolve old
      worry_level = eval(monkey[:operation])

      # new_worry_level = (worry_level / 3)
      new_worry_level = (worry_level % mod)
      throw_to = if (new_worry_level % monkey[:test][:operation]).zero?
                   monkey[:test][:true_outcome].to_i
                 else
                   monkey[:test][:false_outcome].to_i
                 end
      changes << [item, new_worry_level, throw_to]
    end

    changes.each do |change|
      monkey[:items].delete(change[0])
      monkeys[change[2]][:items] << change[1]
    end
  end
end

puts "Part 2: #{inspects.values.sort.reverse[0..1].inject(:*)}"
