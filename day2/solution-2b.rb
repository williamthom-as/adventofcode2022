# frozen_string_literal: true

str = File.read('day2/source.txt')

theirs_translate = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors
}

ours_translate = {
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win
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

  case our_choice
  when :draw
    we_need = their_choice
    score += (3 + outcomes[we_need][:points].to_i)
  when :win
    we_need = outcomes[their_choice][:loses]
    score += (6 + outcomes[we_need][:points].to_i)
  else
    we_need = outcomes[their_choice][:beats]
    score += (0 + outcomes[we_need][:points].to_i)
  end
end

puts "Result: #{score}"
