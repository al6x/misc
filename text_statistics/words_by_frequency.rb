# encoding: utf-8
# 
# Takes text file as an input and calculates the frequencies of occurrences words in text. 
# Outputs file with words and it's frequencies sorted by frequency in descending order.
# 
# Usage: 
# $ ruby words_by_frequency.rb harry_potter.txt
# 

text_file = ARGV[0] || "please specify text file (sample: 'ruby words_by_fequency.rb harry_potter.txt')"

puts "please wait, processing '#{text_file}' file"

words = {}
File.open text_file do |f|
  f.each_line do |line|    
    line.split(/[^a-z]+/i).each do |word|
      next if word.empty? or word.size < 2
      word.downcase!
      words[word] ||= 0
      words[word] += 1
    end
  end
end

sorted_words = words.to_a.sort{|a, b| b[1] <=> a[1]}

statistics_file = "#{text_file}.statistics.txt"

File.open statistics_file, 'w' do |f|
  sorted_words.each do |word, frequency|
    f.puts "#{word} #{frequency}"
  end
end

puts "file '#{text_file}' processed, statistics are in '#{statistics_file}'"