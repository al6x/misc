# encoding: utf-8
# 
# Takes list of project with file filters as an input, and calculates total 
# number of files, lines and characters for each project.
# 
# Usage: 
# - edit this file and specify the projects and file filters.
# - run it
#   $ ruby code_size.rb
#

# 
# Support
# 
raise 'ruby 1.9.2 or higher required!' if RUBY_VERSION < '1.9.2'

String.class_eval do
  def prolongate size
    self.size < size ? (self + (' ' * (size - self.size))) : self
  end
end


# 
# Analytics
# 
projects = {}

# Some interesting Open Source games
projects.merge!({
  catchemrpg:   '/Users/alex/other_projects/catchemrpg/**/*.{java}',
  andors_trail: '/Users/alex/other_projects/andors-trail-read-only/**/*.{java}',
  flare:        '/Users/alex/other_projects/flare/**/*.{cpp,c,h}',
  wrath:        '/Users/alex/other_projects/wrath/**/*.{rb}',
  stratagus:    '/Users/alex/other_projects/stratagus/**/*.{c,cpp,h}',
  btanks:       '/Users/alex/other_projects/btanks/**/*.{c,cpp,h}',
  glest:        '/Users/alex/other_projects/glest/**/*.{c,cpp,h}',
  orona:        '/Users/alex/other_projects/orona/**/*.{js,coffee}',
  springrts:    '/Users/alex/other_projects/spring/**/*.{c,cpp,h}',
  warpg:        '/Users/alex/other_projects/WARPG/**/*.{js}',
  rawkets:      '/Users/alex/other_projects/rawkets/**/*.{js}',
  fontanero:    '/Users/alex/other_projects/fontanero/**/*.{js}',
})

puts "please wait ..."
project_stats = projects.collect do |name, query|
  files, lines, characters = 0, 0, 0

  data = ""
  Dir[query].each do |path|
    files += 1

    File.read(path).force_encoding('binary').gsub(156.chr,"Oe").chars do |c|
      lines += 1 if c == "\n"
      characters += 1 unless c =~ /\s/
    end
  end

  [name, files, lines, characters]
end.sort do |a, b|
  b.last <=> a.last
end

puts %(#{'Name'.to_s.prolongate(20)} #{'Files'.to_s.prolongate(7)} #{'Lines'.prolongate(7)} #{'Chars'.to_s.prolongate(7)})
project_stats.each do |name, files, lines, characters|
  puts %(#{name.to_s.prolongate(20)} #{files.to_s.prolongate(7)} #{(lines / 1000).to_s.prolongate(7)} #{(characters / 1000).to_s.prolongate(7)})
end

# 
# Some interesting Open Source projects
# projects.merge!({
#   wordpress:       '/Users/alex/other_projects/wordpress/**/*.php',
#   drupal:          '/Users/alex/other_projects/drupal-7.2/**/*.php',
#   calipso:         '/Users/alex/other_projects/calipso/**/*.{js}',
#   fat_free_crm:    '/Users/alex/other_projects/fat_free_crm/**/*.{rb,haml,erb,rjs}',
#   shapado:         '/Users/alex/other_projects/shapado/**/*.{rb,haml,erb,rjs}',
#   spree:           '/Users/alex/other_projects/spree/**/*.{rb,haml,erb,rjs}',
#   mongoid:         '/Users/alex/.rvm/gems/ruby-1.9.2-p136/gems/mongoid-2.0.2/**/*.rb',
#   mongo_mapper:    '/Users/alex/.rvm/gems/ruby-1.9.2-p136/gems/mongo_mapper-0.9.1/**/*.rb',
#   active_admin:    '/Users/alex/other_projects/active_admin/**/*.{rb,haml,erb}',
#   rucksack:        '/Users/alex/other_projects/rucksack/**/*.{rb,haml,erb}',
#   railscollab:     '/Users/alex/other_projects/railscollab/**/*.{rb,haml,erb}',
#   redmine:         '/Users/alex/other_projects/redmine/**/*.{rb,haml,erb}',
#   refinerycms:     '/Users/alex/other_projects/refinerycms/**/*.{rb,haml,erb}',
#   teambox:         '/Users/alex/other_projects/teambox/**/*.{rb,haml,erb}',
#   diaspora:        '/Users/alex/other_projects/diaspora/**/*.{rb,haml,erb}',
#   rubinius:        '/Users/alex/other_projects/rubinius/**/*.{rb,c,h}',
#   rad_core:        '/Users/alex/projects/core/**/*.{rb,haml,erb}',  
#   actionpack:      '/Users/alex/.rvm/gems/ruby-1.9.2-p136@sample/gems/actionpack-3.0.9/**/*.{rb,haml,erb}'
# })
# 
# My Projects
# Dir['/Users/alex/projects/*'].each do |path|
#   projects[path.split('/').last] = "#{path}/**/*.{rb,haml,erb}"
# end
# 
# Gems
# Dir['/Users/alex/.rvm/gems/ruby-1.9.2-p136/gems/*'].each do |path|
#   projects[path.split('/').last] = "#{path}/**/*.{rb}"
# end
# 
# Some interesting Open Source games
# projects.merge!({
#   catchemrpg:    '/Users/alex/other_projects/catchemrpg/**/*.{java}',
#   andors:    '/Users/alex/other_projects/andors-trail-read-only/**/*.{java}',
#   flare:     '/Users/alex/other_projects/flare/**/*.{cpp,c,h}',
#   wrath:     '/Users/alex/other_projects/wrath/**/*.{rb}',
#   stratagus: '/Users/alex/other_projects/stratagus/**/*.{c,cpp,h}',
#   osare:     '/Users/alex/other_projects/trunk/**/*.{c,cpp,h}',
#   btanks:    '/Users/alex/other_projects/btanks/**/*.{c,cpp,h}',
#   glest:     '/Users/alex/other_projects/glest/**/*.{c,cpp,h}',
#   orona:     '/Users/alex/other_projects/orona/**/*.{js,coffee}',
#   spring:    '/Users/alex/other_projects/spring/**/*.{c,cpp,h}',
#   fire:      '/Users/alex/projects/**/*.{rb,haml,erb}',
#   warpg:     '/Users/alex/other_projects/WARPG/**/*.{js}'
#   robhawkes: '/Users/alex/other_projects/robhawkes/**/*.{js}',
#   fontanero: '/Users/alex/other_projects/fontanero/**/*.{js}',
# })