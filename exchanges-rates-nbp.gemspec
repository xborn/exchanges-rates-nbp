# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'exchanges/version'

Gem::Specification.new do |spec|
  spec.name          = "exchanges-rates-nbp"
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
  spec.add_runtime_dependency "nokogiri", ["~> 1.6"]
end