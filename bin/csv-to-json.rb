#!/usr/bin/env ruby
require 'json'

work = File.join(Dir.pwd, 'work')
unless File.directory?(work)
  Dir.mkdir(work)
end
File.open(ARGV[0], mode = "rt:sjis:utf-8") do |f|
  header = f.gets.strip
  headers = header.split(',').map do |e|
    e[1...-1]
  end
  f.each_line do |l|
    rows = l.strip.split(',').map do |e|
      e[1...-1].gsub('\\\\', '\\')
    end
    hash = {}
    (0..(headers.length-1)).each do |i|
      hash[headers[i]] = rows[i]
    end
    File.write(File.join(work, hash['キー'] + '.json'), hash.to_json)
  end
end
