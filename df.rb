#!/usr/bin/env ruby

require 'term/ansicolor'
include Term::ANSIColor

Dfin = %x[df -h].split("\n")
dfcln = []
total_size = 0
total_used = 0
total_free = 0

Dfin.each { |li| dfcln << li if li =~ /dev\/sd[a,b,c,d,e]/ }

print "  \t\t", "size", "\t", "used", "\t", "free", "\t", "%", "\n"
print "\e[38;5;236m  -------------------------------------------\e[0m\n"

dfcln.each do |line|
  temp = line.split(" ")

 
  if temp[5] =~ /\/mnt\/\w++++/
    print blue {"  #{temp[5]}"}, "\t", cyan("#{temp[1]}"), "\t", magenta("#{temp[2]}"), "\t", red(bold("#{temp[3]}")), "\t", yellow("#{temp[4]}"), "\n"
  else
    print blue {"  #{temp[5]}"}, "\t\t", cyan("#{temp[1]}"), "\t", magenta("#{temp[2]}"), "\t", red(bold("#{temp[3]}")), "\t", yellow("#{temp[4]}"), "\n"
  end

  if temp[1] =~ /T/
    total_size = total_size + ( temp[1].to_f * 1024 )
  elsif temp[1] =~ /G/
    total_size = total_size + temp[1].to_f
  end

  if temp[2] =~ /T/
    total_used = total_used + ( temp[2].to_f * 1024 )
  elsif temp[2] =~ /G/
    total_used = total_used + temp[2].to_f
  end

  if temp[3] =~ /T/
    total_free = total_free + ( temp[3].to_f * 1024 )
  elsif temp[3] =~ /G/
    total_free = total_free + temp[3].to_f
  end
end

if total_size >= 1024
  total_size = ( total_size.to_f / 1024 )
  total_size = total_size.round(2).to_s + "T"
else
  total_size = total_size.to_s + "G"
end

if total_used >= 1024
  total_used = ( total_used.to_f / 1024 ).round(2).to_s + "T"
else
  total_used = total_used.to_s + "G"
end

if total_free >= 1024
  total_free = ( total_free.to_f / 1024 ).round(2).to_s + "T"
else
  total_free = total_free.to_s + "G"
end

print "\e[38;5;236m  -------------------------------------------\e[0m\n"
print "  total:\t", cyan( bold( "#{total_size}")), "\t", magenta( bold( "#{total_used}")), "\t", red( bold( "#{total_free}")), "\n\n"

