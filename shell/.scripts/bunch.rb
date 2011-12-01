#!/usr/bin/env ruby

require 'ruby_ext'
require 'vfs'
require 'vos'

def projects
  '.'.to_dir.dirs
end

command = ARGV[0]

if command == 'gstatus'
  changed = []
  projects.filter{|dir| dir['.git'].exist?}.each do |dir|  
    puts dir.name
    output = dir.bash("source ~/.profile && gstatus")
    puts output
    changed << dir.name if output !~ /nothing to commit/
  end
  unless changed.empty?
    puts "changed projects: \n#{changed.join(' ')}"
  else
    puts "nothing to commit"
  end


elsif command == 'gcommit'
  message = ARGV[1..-1].join(' ')
  commited = []
  projects.filter{|dir| dir['.git'].exist?}.each do |dir|  
    if dir.bash("source ~/.profile && gstatus") !~ /nothing to commit/
      puts dir.bash(%(source ~/.profile && gcommit "#{message}"))
      commited << dir.name
    end
  end
  unless commited.empty?
    puts "commited: \n#{commited.join(' ')}"
  else
    puts "nothing to commit"
  end

elsif command == 'gpush'
  pushed = []
  projects.filter{|dir| dir['.git'].exist?}.each do |dir|      
    puts dir.bash(%(source ~/.profile && gpush))
    pushed << dir.name
  end
  unless pushed.empty?
    puts "pushed: \n#{commited.join(' ')}"
  else
    puts "nothing to push"
  end

elsif command == 'rake'
  failed = []
  projects.filter{|dir| dir['Rakefile'].exist? and dir['spec'].exist?}.each do |dir|
    begin
      puts
      puts dir.name
      output = dir.bash("rake")      
      puts output
      failed << dir.name if output !~ /0 failures/
    rescue 
      failed << dir.name
    end
  end
  unless failed.empty?
    puts "failed projects: \n#{failed.join(' ')}"
  else
    puts "0 failures"
  end

elsif command == 'release'
  failed = []
  projects.filter{|dir| dir['Rakefile'].exist? and dir.file('Rakefile').read =~ /gem:\s*true/}.each do |dir|
    begin
      puts
      puts dir.name
      output = dir.bash("rake gem:release")      
      puts output
      failed << dir.name if output !~ /successfully released/
    rescue 
      failed << dir.name
    end
  end
  unless failed.empty?
    puts "failed projects: \n#{failed.join(' ')}"
  else
    puts "0 failures"
  end

else
  puts "bunch: unknow command '#{command}'!"
end