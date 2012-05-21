#!/usr/bin/env ruby

require 'fileutils'

class SortNew

  attr_accessor :my_dir, :my_send, :my_ignores, :compare_files

  def initialize
    @my_dir         = '/original/file/dir'
    @my_send        = '/where/to/send/them'
    @ignore_file    = 'path/to/the/_ignores'
    @new_files      = Array.new
    @new_file       = ''

    # load ignore list
    @my_ignore      = Array.new
    @my_ignores     = File.read(@ignore_file).split("\n")

    # load current dir contents
    @compare_files  = Array.new
    @compare_files  = Dir.glob(@my_dir + '*')
  end

  def Run

    # find new files
    @compare_files.each do |comp|
      @new_files << comp if @my_ignores.index(comp) == nil
    end

    # copy to sorting location
    @new_files.each do |nfi|
      @new_file = @my_send + nfi.gsub(/#{@my_dir}/, '')
      FileUtils.cp_r nfi, @new_file
    end

    # rewrite _ignore file
    File.open( @ignore_file, 'a') do |ign|
      @new_files.each do |nfi|
        ign.puts nfi
      end
    end

    # print new files
    if @new_files.length == 0
      puts "\n  \e[1;31mno new files\e[0m\n\n"
    else
      puts "\n  \e[1;34mfile ready to sort: \e[0m"
      @new_files.each{ |f| puts "\e[33m    #{f.gsub("#{@my_dir}", '')}\e[0m" }
      puts ""
    end
  end
end

sort_new = SortNew.new
sort_new.Run
