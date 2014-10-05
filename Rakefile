require "bundler/gem_tasks"

desc "Open an irb session preloaded with this library"
task :console do
  require 'pry'
  require 'nbp'

  ARGV.clear
  Pry.start

  #sh "irb -rubygems -I lib -r nbp.rb"
end