# frozen_string_literal: true

str = File.read('day2/source.txt')

theirs_translate = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors
}

ours_translate = {
  'X' => :rock,
  'Y' => :paper,
  'Z' => :scissors
}

outcomes = {
  rock: {
    beats: :scissors,
    loses: :paper,
    points: 1
  },
  paper: {
    beats: :rock,
    loses: :scissors,
    points: 2
  },
  scissors: {
    beats: :paper,
    loses: :rock,
    points: 3
  }
}

score = 0
str.split("\n").each do |round|
  theirs, ours = round.split(' ')
  their_choice = theirs_translate[theirs]
  our_choice = ours_translate[ours]

  points = outcomes[our_choice][:points].to_i
  score += if their_choice == our_choice
             (3 + points)
           elsif outcomes[their_choice][:loses] == our_choice
             (6 + points)
           else
             points
           end
end

puts "Result: #{score}"
