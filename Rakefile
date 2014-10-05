require "bundler/gem_tasks"

desc "Open an irb session preloaded with this library"
task :console do
  require 'pry'
  require 'exchanges-rates-nbp'

  ARGV.clear
  Pry.start

  #sh "irb -rubygems -I lib -r exchanges-rates-nbp.rb"
end