# frozen_string_literal: true

require "strscan"

str = File.read('day6/source.txt')
scanner = StringScanner.new(str)
window = []

# Solution 1
1.upto(str.length).each do
  if window.length < 4
    window << scanner.getbyte
    next
  else
    if window.uniq.size == 4
      puts "Result @ #{scanner.pos}"
      break
    end

    window = window.drop(1)
    window << scanner.getbyte
  end
end

# Solution 2
str = File.read('day6/source.txt')
scanner = StringScanner.new(str)
window = []

1.upto(str.length).each do
  if window.length < 14
    window << scanner.getbyte
    next
  else
    if window.uniq.size == 14
      puts "Result @ #{scanner.pos}"
      break
    end

    window = window.drop(1)
    window << scanner.getbyte
  end
end
