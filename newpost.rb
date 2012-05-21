#!/usr/bin/env ruby

todayDate = Time.now.strftime('%Y-%m-%d')
puts "Enter title: "
title = gets.chomp

fileName = todayDate + '-' + title.gsub(/ /,'-') + '.md'
fileLocation = '/path/to/jekyll/_posts/'

File.open(fileLocation + fileName, 'w') do |f|
  f.puts '---'
  f.puts 'layout: post'
  f.puts 'title: ' + title
  f.puts '---'
end

editFile = fileLocation + fileName
%x[urxvt -name new_post -e vim #{editFile}]

