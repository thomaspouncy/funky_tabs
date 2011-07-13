require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('funky_tabs', '0.1.6') do |p|
  p.description    = "Create Ajaxified tabs with simple history through window location hashes for Rails."
  p.url            = "http://github.com/thomaspouncy/funky_tabs"
  p.author         = "Thomas Pouncy"
  p.email          = "thomas.pouncy@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }