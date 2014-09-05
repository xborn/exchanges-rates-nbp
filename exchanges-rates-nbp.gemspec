# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'exchanges/version'

Gem::Specification.new do |spec|
  spec.name          = "exchanges-nbp"
  spec.version       = Exchanges::VERSION
  spec.authors       = ["krzysztof.wieslawski"]
  spec.email         = ["krzysztof.wieslawski@gmail.com"]
  spec.summary       = %q{Gem to retrieve exchange rates from the Polish National Bank (NBP)}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-livereload'
  spec.add_development_dependency 'spork-rails'
  spec.add_development_dependency 'guard-spork'
  spec.add_development_dependency 'childprocess'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'nokogiri'
end
